class AddOxygenToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :oxygen, :integer
  end
end
