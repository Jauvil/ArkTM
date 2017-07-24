class AddNameToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :name, :string
  end
end
