# frozen_string_literal: true

# Users COntroller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update]
  def new
    @user = User.new
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your profile information was successfully updated'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Neutron Blog #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = 'You can only edit or delete your own profile'
      redirect_to @user
    end
  end
end
