class RatingsController < ApplicationController
    def index
      @ratings = Rating.all
    end

    def new
      @rating = Rating.new
    end

    def create
      Rating.create params.require(:rating).permit(:beer_id, :score)
    end
  end