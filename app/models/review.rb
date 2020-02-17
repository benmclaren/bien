class Review < ApplicationRecord
  # add associtation that has one to many relationship
  has_many :comments, dependent: :destroy
  has_many :bookmarks
  #add an association to the user
  belongs_to :user

  geocoded_by :address
  after_validation :geocode
  profanity_filter :body
  # add the photo uploader
  mount_uploader :photo, PhotoUploader 

  validates :title, presence: true
  validates :body, length: { minimum: 10 }
  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :restaurant, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :address, presence: true


  def to_param
    id.to_s + "-" + title.parameterize
  end
end
