class HomeController < ApplicationController
  def index
    @reports = Report.for_the_frontpage
    @status = Report.get_current_status
  end
end
