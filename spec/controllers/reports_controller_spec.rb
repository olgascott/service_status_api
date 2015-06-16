require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe "POST create" do
    context "with valid params" do

      it "should respond with 200 if message and status were passed" do
        post :create, {message: 'test', status: 'up', format: :json}
        expect(response.status).to eq 200
      end

      it "should create a report if message and status were passed" do
        expect {
          post :create, {message: 'test', status: 'up', format: :json}
        }.to change(Report, :count).by(1)
      end

      it "should respond with 200 if only message was passed" do
        post :create, {message: 'test', format: :json}
        expect(response.status).to eq 200
      end

      it "should create a report if only message was passed" do
        expect {
          post :create, {message: 'test', format: :json}
        }.to change(Report, :count).by(1)
      end

      it "should respond with 200 if only status was passed" do
        post :create, {status: 'up', format: :json}
        expect(response.status).to eq 200
      end

      it "should create a report if only status was passed" do
        expect {
          post :create, {status: 'up', format: :json}
        }.to change(Report, :count).by(1)
      end

    end

    context "with invalid params" do

      it "should return 422 if status or message were not passed" do
        post :create, {format: :json}
        expect(response.status).to eq 422
      end

      it "should not create a report if status or message were not passed" do
        expect {
          post :create, {format: :json}
        }.to change(Report, :count).by(0)
      end

      it "should return 422 is status was invalid" do
        post :create, {status: 'not a status', format: :json}
        expect(response.status).to eq 422
      end

    end
  end
end
