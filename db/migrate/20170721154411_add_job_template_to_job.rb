class AddJobTemplateToJob < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :job_template, foreign_key: true
  end
end
