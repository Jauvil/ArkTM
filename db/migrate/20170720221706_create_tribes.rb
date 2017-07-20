class CreateTribes < ActiveRecord::Migration[5.1]
  def change
    create_table :tribes do |t|

      t.timestamps
    end
  end
end
