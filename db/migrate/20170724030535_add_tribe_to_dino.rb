class AddTribeToDino < ActiveRecord::Migration[5.1]
  def change
    add_reference :dinos, :tribe, foreign_key: true
  end
end
