class Tribe < ApplicationRecord
  has_many :users
  has_many :job_templates
  has_many :dinos

  def tribe_join_request(user)
    UserMailer.tribe_request(user).deliver_now
    TribeRequest.create!(user_id: user.id, tribe_id: self.id)
  end

  def add_user(user)
    self.users << user
    self.save
  end

  def add_user_via_request(user, tr)
    self.users << user
    self.save
    tr.accepted
  end

  def opt_breed_pair(breed)
    best_male_stats = [ ]
    best_female_stats = { }
    male_same_breed = Dino.dinos_by_sex(self, breed, "Male")
    max_health_value = male_same_breed.maximum(:health)
    max_health_object = male_same_breed.where(health: max_health_value).first
    max_stamina_value = male_same_breed.maximum(:stamina)
    max_stamina_object = male_same_breed.where(stamina: max_stamina_value).first
    max_oxygen_value = male_same_breed.maximum(:oxygen)
    max_oxygen_object = male_same_breed.where(oxygen: max_oxygen_value).first
    max_food_value = male_same_breed.maximum(:food)
    max_food_object = male_same_breed.where(food: max_food_value).first
    max_weight_value = male_same_breed.maximum(:weight)
    max_weight_object = male_same_breed.where(weight: max_weight_value).first
    max_melee_value = male_same_breed.maximum(:melee)
    max_melee_object = male_same_breed.where(melee: max_melee_value).first
    max_movement_speed_value = male_same_breed.maximum(:movement_speed)
    max_movement_speed_object = male_same_breed.where(movement_speed: max_movement_speed_value).first

    best_male_stats.push(max_health_object, max_stamina_object, max_oxygen_object, max_food_object,
                         max_weight_object, max_melee_object, max_movement_speed_object, max_health_object)

    counts = Hash.new(0)
    best_male_stats.each do |each_dino|
      counts[each_dino] += 1
    end
    return counts
  end
end
