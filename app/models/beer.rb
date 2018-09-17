class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def average_rating
        sum=0
        ratings.each do |one|
            sum+=one.score
        end
        return sum / [ratings.count, 1].max
    end

    def to_s
        return name + ", " + brewery.name
    end
end
