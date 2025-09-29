class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :backlog_items
  has_many :games, through: :backlog_items

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
