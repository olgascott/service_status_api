require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  def random_email
    "test-#{(0...12).map { ('a'..'z').to_a[rand(26)] }.join}@example.com"
  end

  describe "POST create" do
    context "with valid params" do
      it "should respond with 200" do
        post :create, {email: random_email, password: '123123', format: :json}
        expect(response.status).to eq 200
      end

      it "should create a user" do
        expect {
          post :create, {email: random_email, password: '123123', format: :json}
        }.to change(User, :count).by(1)
      end

      it "should respond with new user's token" do
        post :create, {email: random_email, password: '123123', format: :json}
        expect(JSON.parse(response.body)['data']['access_token']).to eq User.last.access_token
      end
    end

    context "with invalid params" do
      it "should respond with 422 if email was not passed" do
        post :create, {password: '123123', format: :json}
        expect(response.status).to eq 422
      end

      it "should respond with 422 if password was not passed" do
        post :create, {email: '123123@example.com', format: :json}
        expect(response.status).to eq 422
      end

      it "should respond with 422 if user already exists" do
        user = User.create(email: random_email, password: '123123')
        post :create, {email: user.email, password: 'testtest', format: :json}
        expect(response.status).to eq 422
      end
    end
  end
end
