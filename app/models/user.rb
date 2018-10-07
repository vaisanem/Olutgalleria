class User < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  has_secure_password

  validates :username, uniqueness: true, length: 3..30
  validates :password, format: /(?=.*\d)(?=.*[A-Z])/, length: { minimum: 4 }

  include RatingAverage

  def favourite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favourite_style
    grouped = ratings.group_by { |r| r.beer.style }
    sums = { "Weizen" => 0.0, "Lager" => 0.0, "Pale Ale" => 0.0, "IPA" => 0.0, "Porter" => 0.0 }
    fav = 0.0
    style = nil
    return nil if ratings.empty?

    grouped.keys.each do |s|
      grouped[s].each do |r|
        sums[s] += r.score
      end
      sums[s] /= grouped[s].count
      if sums[s] > fav
        fav = sums[s]
        style = s
      end
    end
    style
  end

  def favourite_brewery
    grouped = ratings.group_by { |r| r.beer.brewery.id }
    fav = 0.0
    b = nil
    return nil if ratings.empty?

    grouped.keys.each do |s|
      a = 0
      grouped[s].each do |r|
        a += r.score.to_f
      end
      a /= grouped[s].count
      if a > fav
        fav = a
        b = grouped[s][0].beer.brewery
      end
    end
    b
  end

  def already_a_member(beer_club)
    beer_clubs.member?(beer_club)
  end
end
