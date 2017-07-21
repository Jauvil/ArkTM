class Tribe < ApplicationRecord
  has_many :users
  has_many :job_templates

  def tribe_join_request(user)
    UserMailer.tribe_request(user).deliver_now
    TribeRequest.create!(user_id: user.id, tribe_id: self.id)
  end

  def add_user(user)
    self.users << user
    self.save
  end

  def add_user_via_request(user, tr)
    self.users << user
    self.save
    tr.accepted
  end
end
