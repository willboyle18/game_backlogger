# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
  email_address: "test@example.com",
  password: "password",
  password_confirmation: "password"
)

User.create!(
  email_address: "test2@example.com",
  password: "password",
  password_confirmation: "password"
)

User.create!(
  email_address: "test3@example.com",
  password: "password",
  password_confirmation: "password"
)


# Accepted request from test1 to test2
Friend.create!(
  user_id: 1,
  friend_id: 2,
  status: "accepted"
)

# Outgoing request from test2 to test3
Friend.create!(
  user_id: 2,
  friend_id: 3,
  status: "pending"
)

# Outgoing request from test3 to test1
Friend.create!(
  user_id: 3,
  friend_id: 1,
  status: "pending"
)