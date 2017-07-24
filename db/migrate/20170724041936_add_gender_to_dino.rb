class AddGenderToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :gender, :string
  end
end
