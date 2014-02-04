class UsersController < ApplicationController
  before_action :authenticated_redirect
  before_action :signed_in_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to pbctl!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in or sign up." unless signed_in?
    end
end
