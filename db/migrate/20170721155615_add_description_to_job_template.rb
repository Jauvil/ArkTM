class AddDescriptionToJobTemplate < ActiveRecord::Migration[5.1]
  def change
    add_column :job_templates, :description, :text
  end
end
