class Task < ApplicationRecord
  belongs_to :member
  belongs_to :project
  has_many :activities

  # in sec
  def tracked
    activities.sum(:tracked)
  end

  def tracked_hours
    (tracked/3600.0).ceil(1)
  end

  def tracked_azure_update
    AzureClient.new.task_update_completed_work(
      project.organization.azure_id,
      project.azure_id,
      azure_id,
      tracked_hours,
      project.organization.azure_access_token
    )
  end
end
