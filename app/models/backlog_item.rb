class BacklogItem < ApplicationRecord
  belongs_to :user
  belongs_to :game

  enum :status, { not_started: 0, currently_playing: 1, dropped: 2, completed: 3 }

  validates :user_id, uniqueness: { scope: :game_id }
end
