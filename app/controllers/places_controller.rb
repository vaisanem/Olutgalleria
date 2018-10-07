class PlacesController < ApplicationController
  def index
  end

  def show
    places = Rails.cache.read(session[:city])
    @place = places.find { |place| place.id == params[:id]}
    redirect_to places_path if !@place
  end

  def search
    session[:city] = params[:city]
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end
