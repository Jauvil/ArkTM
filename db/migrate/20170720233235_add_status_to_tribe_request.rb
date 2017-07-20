class AddStatusToTribeRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :tribe_requests, :status, :string, :default => 'active'
  end
end
