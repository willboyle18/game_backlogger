class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: [ :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      email_address: user_params[:email_address],
      username: user_params[:username],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation]
    )

    if @user.save
      start_new_session_for(@user)
      redirect_to after_authentication_url, notice: "Welcome! You have signed up successfully."
    else
      render "sessions/new", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
  end
end
