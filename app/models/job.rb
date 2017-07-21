class Job < ApplicationRecord
  belongs_to :job_template
  belongs_to :user

  ## id                                      integer, primary key
  ## created_at                              datetime
  ## update_at                               datetime
  ## user_id                                 user, fk
  ## job_template_id                         job_template, fk


end
