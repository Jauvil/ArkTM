class AddTribeToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :tribe, foreign_key: true
  end
end
