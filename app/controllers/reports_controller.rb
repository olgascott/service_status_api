class ReportsController < ApplicationController
  before_filter :validate_params

  def create
    @report = Report.new(status: params[:status], message: params[:message])
    if @report.save
      api_response_ok
    else
      api_response_unprocessable_entity # Report could not have been created
    end
  end

  protected

  def validate_params
    return api_response_unprocessable_entity unless (params[:status].present? || params[:message].present?) # Return 422 is nothing was passed
  end
end