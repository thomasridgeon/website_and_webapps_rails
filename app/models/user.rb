class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_secure_password

  # generate a random salt for encryption when a new user is created
  before_create :generate_salt

  # --- Key derivation for notes encryption ---
  def derive_key(password, salt)
    OpenSSL::PKCS5.pbkdf2_hmac(
      password,
      salt,
      200_000, # iterations
      32,      # key length in bytes
      "sha256" # hash algorithm
    )
  end

  private

  def generate_salt
    self.salt = SecureRandom.hex(16)
  end
end
