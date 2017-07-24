class CreateDinos < ActiveRecord::Migration[5.1]
  def change
    create_table :dinos do |t|

      t.timestamps
    end
  end
end
