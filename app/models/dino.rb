class Dino < ApplicationRecord
  belongs_to :tribe

  scope :dinos_by_breed, ->(tribe, breed) {
    where(tribe: tribe, breed: breed)
  }

  scope :female_dinos, -> { where(gender: "Female") }


  scope :male_dinos, -> { where(gender: "Male") }


end
