class Member < ApplicationRecord
  has_and_belongs_to_many :organizations

  def name
    azure_email
  end

  def hubstaff_status
    hubstaff_id.present? ? 'HB connected' : 'HB not connected'
  end
end
