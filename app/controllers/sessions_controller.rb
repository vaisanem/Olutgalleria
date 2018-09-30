class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    user = user.authenticate(params[:password])
    if user
      session[:user_id] = user.id if !user.nil?
      redirect_to user, notice: "Welcome back!"
    else
      redirect_to login_path, notice: "Wrong credentials."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
