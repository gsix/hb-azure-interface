class Organization < ApplicationRecord
  has_and_belongs_to_many :members
  has_many :projects, dependent: :destroy

  def title
    azure_id
  end

  # ! use this method instead hubstaff_access_token in HubstaffClient requests
  def fresh_hubstaff_access_token
    # still fresh
    return hubstaff_access_token if hubstaff_token_will_end - 2.hours > DateTime.now

    res = HubstaffClient.new.refresh_access_token_request hubstaff_refresh_token

    raise StandardError, res.parsed_response['error'] if res.code != 200

    self.hubstaff_access_token = res.parsed_response['access_token']
    self.hubstaff_refresh_token = res.parsed_response['refresh_token']
    self.hubstaff_token_get_at = DateTime.now
    self.hubstaff_token_will_end = DateTime.now + (res.parsed_response['expires_in'].to_i / 60.0 / 60.0).round.hours

    self.save
  end
end
