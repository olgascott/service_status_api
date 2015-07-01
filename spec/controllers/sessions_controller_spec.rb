require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  def random_email
    "test-#{(0...12).map { ('a'..'z').to_a[rand(26)] }.join}@example.com"
  end

  context "POST create" do
    it "should respond with 200 if user exists and password is correct" do
      user = User.create(email: random_email, password: '123123')
      post :create, {email: user.email, password: '123123', format: :json}
      expect(response.status).to eq 200
    end

    it "should respond with access token" do
      user = User.create(email: random_email, password: '123123')
      post :create, {email: user.email, password: '123123', format: :json}
      expect(JSON.parse(response.body)['data']['access_token']).to eq user.access_token
    end

    it "should respond with 422 if user exists but password is not correct" do
      user = User.create(email: random_email, password: '123123')
      post :create, {email: user.email, password: 'qwqwqw', format: :json}
      expect(response.status).to eq 422
    end

    it "should respond with 422 if user doesn't exists" do
      post :create, {email: "123@example.com", password: 'qwqwqw', format: :json}
      expect(response.status).to eq 422
    end
  end
end
