class Task < ApplicationRecord
  belongs_to :member
  belongs_to :project
  has_many :activities
end
