class AddMovementSpeedToDino < ActiveRecord::Migration[5.1]
  def change
    add_column :dinos, :movement_speed, :integer
  end
end
