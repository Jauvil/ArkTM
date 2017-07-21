class CreateJobTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :job_templates do |t|

      t.timestamps
    end
  end
end
