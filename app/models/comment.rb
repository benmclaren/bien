class Comment < ApplicationRecord
  belongs_to :review
  profanity_filter :body
  validates :body, presence: true
end
