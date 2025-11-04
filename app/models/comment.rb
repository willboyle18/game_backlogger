class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :user, presence: true
  validates :commentable, presence: true
end
