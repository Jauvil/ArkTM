class AddNameToJobTemplate < ActiveRecord::Migration[5.1]
  def change
    add_column :job_templates, :name, :string
  end
end
