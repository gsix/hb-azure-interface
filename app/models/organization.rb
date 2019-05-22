class Organization < ApplicationRecord
  has_and_belongs_to_many :members
  has_many :projects, dependent: :destroy

  def title
    azure_id
  end

  # ! use this method instead hubstaff_access_token in HubstaffClient requests
  def fresh_hubstaff_access_token
    raise 'Organiaztion not connected to HB. Please edit hubstaff start auth code.' if hubstaff_token_will_end.blank?

    # still fresh
    return hubstaff_access_token if hubstaff_token_will_end - 2.hours > DateTime.now

    res = HubstaffClient.new.refresh_access_token_request hubstaff_refresh_token

    raise StandardError, res.parsed_response['error'] if res.code != 200

    self.hubstaff_access_token = res.parsed_response['access_token']
    self.hubstaff_refresh_token = res.parsed_response['refresh_token']
    self.hubstaff_token_get_at = DateTime.now
    self.hubstaff_token_will_end = DateTime.now + (res.parsed_response['expires_in'].to_i / 60.0 / 60.0).round.hours

    self.save

    hubstaff_access_token
  end

  def hubstaff_projects
    Rails.cache.fetch("organizations/#{id}/hubstaff_projects", expires_in: 1.minute) do
      res = HubstaffClient.new.organization_projects fresh_hubstaff_access_token, hubstaff_id
      res.parsed_response['projects']
    end
  end

  def self.hubstaff_users
    Rails.cache.fetch('hubstaff_users', expires_in: 2.hours) do
      raw_users = []

      Organization.all.each do |organization|
        res = HubstaffClient.new.organization_members organization.fresh_hubstaff_access_token, organization.hubstaff_id
        user_ids = res.parsed_response['members'].pluck('user_id')

        users = user_ids.map do |user_id|
          res = HubstaffClient.new.organization_user organization.fresh_hubstaff_access_token, user_id
          parsed = res.parsed_response['user']
          {
            'id' => parsed['id'],
            'name' => "#{parsed['name']} <#{parsed['email']}>"
          }
        end

        raw_users << users
      end

      raw_users.flatten.uniq
    end
  end
end
