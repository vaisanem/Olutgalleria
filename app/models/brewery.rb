class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def average_rating
        sum=ratings.inject(0) {|sum, n| sum+n.score}
        return sum / [ratings.count, 1].max
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
