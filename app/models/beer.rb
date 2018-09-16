class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        sum=0
        all=Rating.all
        all.each do |one|
            sum+=one.score
        end
        return sum / (ratings.count || 1)
    end

    def to_s
        return name + ", " + brewery.name
    end
end
