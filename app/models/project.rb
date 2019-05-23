class Project < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :organization
  has_many :tasks, dependent: :destroy
  has_many :activities

  def title
    azure_name
  end

  def hubstaff_status
    hubstaff_id.present? ? 'HB connected' : 'HB not connected'
  end

  def tracked
    activities.sum(:tracked)
  end

  def tracked_hours
    (tracked/3600.0).ceil(1)
  end

  def create_project_in_hubstaff
    members = organization.members.select {|mem| mem.hubstaff_id.present? }.map {|mem| { 'user_id' => mem.hubstaff_id.to_i, 'role' => 'user' }}

    res = HubstaffClient.new.organization_project_create organization.hubstaff_access_token, organization.hubstaff_id, azure_name, members
    self.hubstaff_id = res.parsed_response['project']['id']
    self.save
  end

  def azure_hooks_create
    access_token = Rails.application.credentials[Rails.env.to_sym][:api_access_token]
    azure_hook_create 'workitem.created', azure_hook_task_create_url(token: access_token)
    azure_hook_create 'workitem.updated', azure_hook_task_update_url(token: access_token)
    azure_hook_create 'workitem.deleted', azure_hook_task_destroy_url(token: access_token)
    true
  end

  def azure_hook_create event_type, callback_url
    AzureClient.new.project_subscription_create(
      organization.azure_id,
      azure_id,
      event_type,
      callback_url,
      organization.azure_access_token
    )
  end
end
