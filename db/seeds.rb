# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin_username = ENV.fetch("BLOG_ADMIN_USERNAME")
admin_password = ENV.fetch("BLOG_ADMIN_PASSWORD")

admin = BlogUser.find_or_initialize_by(username: admin_username)
admin.password = admin_password
admin.password_confirmation = admin_password
admin.admin = true
admin.save!

puts "Seeded admin user: #{admin.username}"
