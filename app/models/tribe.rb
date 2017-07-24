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
    male_hash = self.best_stats(breed, "Male")
    female_hash = self.best_stats(breed, "Female")
    if female_hash != nil
      sorted_female_hash = female_hash.sort_by{|_, v| v}.reverse
      best_female = Dino.where(breed: breed, name: sorted_female_hash[0][0]).first
    end
    if male_hash != nil
      sorted_male_hash = male_hash.sort_by{|_, v| v}.reverse
      best_male = Dino.where(breed: breed, name: sorted_male_hash[0][0]).first
    end
    return [best_male, best_female]
  end

  def best_stats(breed, gender)
    best_stats = [ ]
    same_breed_gender = Dino.dinos_by_sex(self, breed, gender)
    max_health_value = same_breed_gender.maximum(:health)
    max_health_object = same_breed_gender.where(health: max_health_value).first
    max_stamina_value = same_breed_gender.maximum(:stamina)
    max_stamina_object = same_breed_gender.where(stamina: max_stamina_value).first
    max_oxygen_value = same_breed_gender.maximum(:oxygen)
    max_oxygen_object = same_breed_gender.where(oxygen: max_oxygen_value).first
    max_food_value = same_breed_gender.maximum(:food)
    max_food_object = same_breed_gender.where(food: max_food_value).first
    max_weight_value = same_breed_gender.maximum(:weight)
    max_weight_object = same_breed_gender.where(weight: max_weight_value).first
    max_melee_value = same_breed_gender.maximum(:melee)
    max_melee_object = same_breed_gender.where(melee: max_melee_value).first

    if max_health_value != nil
      best_stats.push(max_health_object, max_stamina_object, max_oxygen_object, max_food_object,
                         max_weight_object, max_melee_object, max_health_object)
      counts = Hash.new(0)
      best_stats.each do |each_dino|
        counts[each_dino.name] += 1
      end
      return counts
    end
  end
end
