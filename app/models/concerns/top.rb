module Top
  extend ActiveSupport::Concern

  def top(amount)
    all.sort_by{ |i| -i.average_rating }[0..amount - 1]
  end
end
