class CreateTribeRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :tribe_requests do |t|

      t.timestamps
    end
  end
end
