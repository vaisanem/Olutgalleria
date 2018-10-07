class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new beer_id: params[:rating][:beer_id], score: params[:rating][:score]
    @rating.user = current_user
    if @rating.user 
      if @rating.save
        redirect_to current_user
      else
        redirect_to new_rating_path
      end
    else
      redirect_to login_path, notice: 'you should be signed in'
    end
  end

  def destroy
    rating = Rating.find_by(id: params[:id].to_s)
    rating.delete if current_user == rating.user
    redirect_to rating.user
  end
end
