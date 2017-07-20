class AddUserToTribeRequest < ActiveRecord::Migration[5.1]
  def change
    add_reference :tribe_requests, :user, foreign_key: true
  end
end
