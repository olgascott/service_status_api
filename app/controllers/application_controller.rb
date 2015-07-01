class ApplicationController < ActionController::Base
  def api_response_unprocessable_entity(error_message = nil)
    render json: { data: nil, errors: error_message }, status: :unprocessable_entity
  end

  def api_response_ok
    render json: { data: nil }, status: :ok
  end
end
