class HomeController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:index]

  def index
    @reports = Report.for_the_frontpage
    @status = Report.get_current_status
  end
end
