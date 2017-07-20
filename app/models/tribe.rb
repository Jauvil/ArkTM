class Tribe < ApplicationRecord
  has_many :users
  has_many :tribe_requests

  def tribe_join_request(user)
    UserMailer.tribe_request(user).deliver_now
    TribeRequest.create!(user_id: user.id, tribe_id: self.id)
  end
end
