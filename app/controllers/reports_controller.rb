class ReportsController < ApplicationController
  before_filter :validate_params, :require_admin, only: [:create]
  skip_before_action :authenticate_user_from_token!, only: [:index, :current_status]

  def create
    @report = Report.new(status: params[:status], message: params[:message])
    if @report.save
      render json: @report, serializer: ReportSerializer, root: 'data'
    else
      api_response_unprocessable_entity(@report.errors.messages)
    end
  end

  def index
    reports = Report.for_the_frontpage
    render json: reports, each_serializer: ReportSerializer, root: 'data'
  end

  def current_status
    data = {status: Report.get_current_status}
    api_response_ok(data)
  end

  protected

  def validate_params
    return api_response_unprocessable_entity unless (params[:status].present? || params[:message].present?) # Return 422 is nothing was passed
  end
end
