class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user

  profanity_filter :body
  validates :body, presence: true
end
