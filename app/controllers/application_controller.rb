class ApplicationController < ActionController::Base
  before_action :authenticate_user_from_token!


  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']

    if auth_token
      authenticate_with_auth_token auth_token
    else
      api_response_unauthorized
    end
  end

  def require_admin
    unless current_user.is_admin?
      api_response_permission_denied
    end
  end

  # API responses -->
  def api_response_unprocessable_entity(error_message = nil)
    render json: { data: nil, errors: error_message }, status: :unprocessable_entity
  end

  def api_response_ok(data = nil)
    render json: { data: data }, status: :ok
  end

  def api_response_unauthorized
    render json: { data: nil, errors: {user: ["Is not signed in"]} }, status: 401
  end

  def api_response_permission_denied
    render json: { data: nil, errors: {user: ["Action requires admin user"]} }, status: 401
  end
  #<-- API responses

  private

  def authenticate_with_auth_token(auth_token)
    unless auth_token.include?(':')
      api_response_unauthorized
      return
    end

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.access_token, auth_token)
      sign_in user, store: false
    else
      api_response_unauthorized
    end
  end
end
