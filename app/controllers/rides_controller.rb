class RidesController < ApplicationController
  def create
    @ride = Ride.create(check_params)
    @message = @ride.take_ride
    redirect_to user_path(@ride.user, message: @message)
  end

  private

  def check_params
    params.permit(:user_id, :attraction_id)
  end
end
