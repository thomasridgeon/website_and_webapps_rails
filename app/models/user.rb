class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_secure_password

  # generate a random salt for encryption when a new user is created
  before_create :generate_salt

  private

  def generate_salt
    self.salt = SecureRandom.hex(16)
  end
end
