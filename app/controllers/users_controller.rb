class UsersController < ApplicationController
  def create
    @user = User.new user_params
    if @user.save
      render json: @user, serializer: SessionSerializer, root: nil
    else
      api_response_unprocessable_entity(@user.errors.messages)
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
