module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.inject(0) { |sum, n| sum + n.score } / [ratings.count.to_f, 1.0].max
  end
end
