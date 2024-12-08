# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
User.destroy_all

# Seed users
User.create!(
  [
    { name: 'Developer', email_address: 'dev@developer.com', password: 'Password@123' },
    { name: 'User Test 1', email_address: 'user1@test.com', password: 'Password@123' },
    { name: 'User Test 2',  email_address: 'user2@test.com', password: 'Password@123' }
  ]
)

puts "Seeded #{User.count} users!"
