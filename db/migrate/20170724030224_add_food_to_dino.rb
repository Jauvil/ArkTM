class AddFoodToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :food, :integer
  end
end
