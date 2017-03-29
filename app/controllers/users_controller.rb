class UsersController < ApplicationController
  def home
  end

  def show
    @message = params[:message] if params[:message]
    @user = User.find(params[:id])

    if !logged_in?(@user)
      flash[:notice] = "Sign Up"
      flash[:message] = "or sign in with valid user/password"
      redirect_to '/'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params_check)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def update
    @user = User.find(params[:id])
    attraction_name = params[:attraction_name]
    attraction_height = params[:attraction_height]
    tickets_amount = params[:tickets_amount]
    happiness_rating = params[:happiness_rating]

    if tickets_check!(@user, tickets_amount)
      if height_check!(@user, attraction_height)
        update_user!(@user, tickets_amount, happiness_rating)
        flash[:notice] = "Thanks for riding the #{attraction_name}!"
        redirect_to user_path(@user)
      else
        flash[:notice] = "You are not tall enough to ride the #{attraction_name}"
        redirect_to user_path(@user)
      end
    else
      flash[:notice] = "You do not have enough tickets to ride the #{attraction_name}"
      flash[:alert] = "You are not tall enough to ride the #{attraction_name}" unless height_check!(@user, attraction_height)
      redirect_to user_path(@user)
    end
  end

  private

  def params_check
    params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :password, :admin)
  end

  def logged_in?(user)
    session[:user_id] == user.id
  end

  def update_user!(user, tickets_amount, happiness_rating)
    user.tickets -= tickets_amount.to_i
    user.happiness = happiness_rating
    user.save
  end

  def height_check!(user, attraction_height)
    if user.height >= attraction_height.to_i
      return true
    else
      return false
    end
  end

  def tickets_check!(user, tickets_amount)
    user.tickets >= tickets_amount.to_i
  end
end
