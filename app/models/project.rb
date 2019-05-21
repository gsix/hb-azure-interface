class Project < ApplicationRecord
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
end
