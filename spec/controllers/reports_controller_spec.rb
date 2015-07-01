require 'spec_helper'

RSpec.describe ReportsController, type: :controller do
  def create_random_user
    User.create(email: "test-#{(0...12).map { ('a'..'z').to_a[rand(26)] }.join}@example.com", password: '123123')
  end

  def sign_in_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create_random_user
    @user.update_attributes(is_admin: true)
    request.headers['Authorization'] = @user.access_token
  end

  describe "GET index" do
    it "should respond with 200" do
      get :index, {format: :json}
      expect(response.status).to eq 200
    end
  end

  describe "GET current_status" do
    it "should respond with 200" do
      get :current_status, {format: :json}
      expect(response.status).to eq 200
    end
  end

  describe "POST create" do
    context "with valid params" do
      before(:each) do
        sign_in_user
      end

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
      before(:each) do
        sign_in_user
      end

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

    context "user permissions" do
      it "should return 401 if user is not signed in" do
        post :create, {message: 'test', status: 'up', format: :json}
        expect(response.status).to eq 401
      end

      it "should return 401 if user signed in, but is not an admin" do
        sign_in_user
        @user.update_attributes(is_admin: false)
        post :create, {message: 'test', status: 'up', format: :json}
        expect(response.status).to eq 401
      end
    end
  end
end
