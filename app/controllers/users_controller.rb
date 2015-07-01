class UsersController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:create]

  def create
    @user = User.new user_params
    if @user.save
      render json: @user, serializer: SessionSerializer, root: 'data'
    else
      api_response_unprocessable_entity(@user.errors.messages)
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
