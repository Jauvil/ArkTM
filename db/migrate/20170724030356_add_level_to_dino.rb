class AddLevelToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :level, :integer
  end
end
