require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET index" do
    it "should render correct template" do
      post :index
      expect(response).to render_template("index")
    end

    it "should set correct status" do
      allow(Report).to receive(:get_current_status).and_return('up')
      post :index
      expect(assigns(:status)).to eq 'up'
    end

    it "should set correct reports" do
      report_1 = Report.create(message: 'test')
      report_2 = Report.create(message: 'test2')
      post :index
      expect(assigns(:reports)).to eq [report_2, report_1]
    end
  end
end
