class AddNameToTribe < ActiveRecord::Migration[5.1]
  def change
    add_column :tribes, :name, :string
  end
end
