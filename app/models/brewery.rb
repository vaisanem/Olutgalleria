class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than: 1039,
                                   less_than_or_equal_to: ->(_) { Time.now.year },
                                   only_integer: true }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  include RatingAverage
  extend Top

  def self.top_breweries(amount)
    Brewery.all.sort_by{ |b| -b.average_rating }[0..amount - 1]
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end
end
