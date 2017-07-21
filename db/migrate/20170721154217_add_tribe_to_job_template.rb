class AddTribeToJobTemplate < ActiveRecord::Migration[5.1]
  def change
    add_reference :job_templates, :tribe, foreign_key: true
  end
end
