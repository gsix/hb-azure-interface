class Activity < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :project

  def self.import_from_hubstaff
    Organization.all.each do |organization|
      raw_activities = HubstaffClient.new.organization_activities organization.hubstaff_access_token, organization.hubstaff_id

      raw_activities['activities'].each do |raw_activity|
        next if Activity.where(hubstaff_id: raw_activity['id']).any?

        activity = Activity.new

        project = Project.find_by_hubstaff_id(raw_activity['project_id'])
        activity.project = project

        task = Task.find_by_hubstaff_id(raw_activity['task_id'])
        activity.task = task

        activity.tracked = raw_activity['tracked']
        activity.hubstaff_id = raw_activity['id']

        activity.save!
      rescue => e
        Rails.logger.error e
      end
    end
  end
end
