class AddTribeToTribeRequest < ActiveRecord::Migration[5.1]
  def change
    add_reference :tribe_requests, :tribe, foreign_key: true
  end
end
