class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user_id, uniqueness: { scope: :friend_id }
  validates :not_duplicate_in_reverse


  scope :pending, -> {where(status: "pending")}
  scope :accepted, -> {where(status: "accepted")}


  def not_duplicate_in_reverse
    if Friend.exists?(user_id: friend_id, friend_id: user_id)
      errors.add(:base, "Friendship already exists in reverse")
    end
  end
end