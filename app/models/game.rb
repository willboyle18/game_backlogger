class Game < ApplicationRecord
  has_many :backlog_items, dependent: :destroy
  has_many :users, through: :backlog_items
  validates :name, presence: true
end