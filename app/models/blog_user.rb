class BlogUser < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  # :presence: true ensures a username is required, and uniqueness:true ensures no two users can have the same username
end
