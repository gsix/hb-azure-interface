class Member < ApplicationRecord
  include Connectable

  has_and_belongs_to_many :organizations

  def name
    azure_email
  end
end
