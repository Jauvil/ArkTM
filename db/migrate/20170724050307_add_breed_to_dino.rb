class AddBreedToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :breed, :string
  end
end
