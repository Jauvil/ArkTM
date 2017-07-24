class AddStaminaToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :stamina, :integer
  end
end
