class ApplicationController < ActionController::Base
  def api_response_unprocessable_entity
    render json: { data: nil }, status: :unprocessable_entity
  end

  def api_response_ok
    render json: { data: nil }, status: :ok
  end
end
