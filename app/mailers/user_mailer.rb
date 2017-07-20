class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def tribe_request(user)
    @user = user
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'A new player has requested to join your tribe')
  end
end
