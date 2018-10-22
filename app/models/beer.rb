class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  include RatingAverage
  extend Top

  def to_s
    name + ", " + brewery.name
  end

  def self.top_beers(amount)
    Beer.all.sort_by{ |b| -b.average_rating }[0..amount - 1]
  end
end
