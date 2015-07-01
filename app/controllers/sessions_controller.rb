class SessionsController < ApplicationController

  def create
    @user = User.find_for_authentication(email: params[:email])
    return invalid_login_attempt unless @user

    if @user.valid_password?(params[:password])
      sign_in :user, @user
      render json: @user, serializer: SessionSerializer, root: nil
    else
      invalid_login_attempt
    end
  end

  private

  def invalid_login_attempt
    warden.custom_failure!
    api_response_unprocessable_entity({user: ["Invalid email or password."]}) #One error message for both for security reasons
  end
end
