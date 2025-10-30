class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :body, presence: true
  validates :user_id, uniqueness: { scope: :game_id }
end
