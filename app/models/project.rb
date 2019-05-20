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
end
