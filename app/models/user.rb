class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :backlog_items
  has_many :games, through: :backlog_items

  has_many :reviews, dependent: :destroy
  has_many :reviewed_games, through: :reviews, source: :game

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :friends, class_name: "Friend", foreign_key: "user_id", dependent: :destroy

  has_many :inverse_friends, class_name: "Friend", foreign_key: "friend_id", dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :received_comments,
           as: :commentable,
           class_name: "Comment",
           dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, confirmation: true

  def all_friends
    outgoing = friends.accepted.includes(:friend).map(&:friend)
    incoming = inverse_friends.accepted.includes(:user).map(&:user)
    (outgoing + incoming).uniq
  end

  def outgoing_requests
    outgoing = friends.pending.includes(:friend).map(&:friend)
    outgoing.uniq
  end

  def incoming_requests
    incoming = inverse_friends.pending.includes(:user).map(&:user)
    incoming.uniq
  end
end
