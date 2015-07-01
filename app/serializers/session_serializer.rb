class SessionSerializer < ActiveModel::Serializer
  attributes :email, :user_id, :access_token

  def user_id
    object.id
  end

end
