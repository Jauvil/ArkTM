class AddHealthToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :health, :integer
  end
end
