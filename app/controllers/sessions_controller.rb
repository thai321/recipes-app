class SessionsController < ApplicationController

  def new

  end

  def create
    chef = Chef.find_by(email: params[:session][:email].downcase)
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id
      cookies.signed[:chef_id] = chef.id
      flash[:success] = "You have successully logged in"
      # flash here won't work in partial back form message
      redirect_to chef
    else
      flash.now[:danger] = "There was something wrong with your login information" # use now since we can't use it in partial errors
      render 'new'
    end
  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end
