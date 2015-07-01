class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :update_access_token!

  private

  def update_access_token!
    self.update_attributes(access_token: "#{self.id}:#{Devise.friendly_token}")
  end
end
