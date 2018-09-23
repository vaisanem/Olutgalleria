class User < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  has_secure_password

  validates :username, uniqueness: true, length: 3..30
  validates :password, format: /(?=.*\d)(?=.*[A-Z])/, length: { minimum: 4 }

  include RatingAverage
end
