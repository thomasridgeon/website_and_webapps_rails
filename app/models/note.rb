class Note < ApplicationRecord
  belongs_to :user
  CIPHER_ALGO = "aes-256-gcm"

  # Encrypt plaintext and return a Note object (not saved)
  def self.encrypt(plaintext, key)
    cipher = OpenSSL::Cipher.new(CIPHER_ALGO).encrypt
    cipher.key = key
    iv = cipher.random_iv
    cipher.iv = iv
    cipher.auth_data = ""
    ciphertext = cipher.update(plaintext) + cipher.final
    tag = cipher.auth_tag

    new(
      ciphertext: Base64.encode64(ciphertext),
      iv: Base64.encode64(iv),
      tag: Base64.encode64(tag)
    )
  end

  # Decrypt stored ciphertext
  def decrypt(key)
    decipher = OpenSSL::Cipher.new(CIPHER_ALGO).decrypt
    decipher.key = key
    decipher.iv = Base64.decode64(iv)
    decipher.auth_tag = Base64.decode64(tag)
    decipher.auth_data = ""
    ciphertext_binary = Base64.decode64(ciphertext)
    decipher.update(ciphertext_binary) + decipher.final
  end
end
