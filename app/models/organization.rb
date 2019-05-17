class Organization < ApplicationRecord
  has_and_belongs_to_many :members
  has_many :projects, dependent: :destroy

  def title
    azure_id
  end
end
