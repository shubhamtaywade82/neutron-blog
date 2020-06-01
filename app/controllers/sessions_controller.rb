# frozen_string_literal: true

# frozen_
class SessionsController < ApplicationController
  before_action :check_login

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in successfully'
      redirect_to user
    else
      flash.now[:alert] = 'there was something wrong with your login details'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to root_path
  end

  private

  def check_login
    if logged_in?
      flash[:alert] = 'You already logged in'
      redirect_to root_path
    end
  end
end
