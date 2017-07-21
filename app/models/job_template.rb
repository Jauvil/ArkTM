class JobTemplate < ApplicationRecord
  has_many :jobs
  belongs_to :tribe
end
