class User < ApplicationRecord
  after_create :generate_access_token

  devise :database_authenticatable,
         :recoverable, :rememberable

  def generate_access_token
    self.update_attribute :access_token, SecureRandom.hex
  end
end
