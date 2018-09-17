class RatingsController < ApplicationController
    def index
      @ratings = Rating.all
    end

    def new
      @rating = Rating.new
      @beers = Beer.all
    end

    def create
      #Rating.create params.require(:rating).permit(:beer_id, :score)
      Rating.create beer_id: params[:beer_id], score: params[:rating][:score]
      redirect_to ratings_path
    end

    def destroy
      Rating.find_by(id:"#{params[:id]}").delete
      redirect_to ratings_path
    end
  end