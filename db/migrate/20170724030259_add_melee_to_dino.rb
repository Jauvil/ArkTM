class AddMeleeToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :melee, :integer
  end
end
