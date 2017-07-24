class Dino < ApplicationRecord
  belongs_to :tribe

  scope :dinos_by_sex, ->(tribe, breed, gender) {
    where(tribe: tribe, breed: breed, gender: gender)
  }

end
