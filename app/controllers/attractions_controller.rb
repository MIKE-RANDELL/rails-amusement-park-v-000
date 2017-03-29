class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
    @user = User.find(session[:user_id])
  end

  def show
    @attraction = Attraction.find(params[:id])
    @ride = Ride.new
    @user = User.find(session[:user_id])
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.create(params_check)
    redirect_to attraction_path(@attraction)
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    @attraction = Attraction.find(params[:id])
    @attraction.update(params_check)
    redirect_to attraction_path(@attraction)
  end

  private

  def params_check
    params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
  end
end
