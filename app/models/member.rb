class Member < ApplicationRecord
  has_and_belongs_to_many :organizations

  def name
    azure_email
  end

  def hubstaff_status
    hubstaff_id.present? ? 'Синхронизировано с Hubstaff' : 'Не подключено к Hubstaff'
  end
end
