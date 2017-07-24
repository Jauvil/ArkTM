class AddWeightToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :weight, :integer
  end
end
