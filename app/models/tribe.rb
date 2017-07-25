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
    male_hash = self.best_stats(breed)
    female_hash = self.best_stats(breed)
    if female_hash.present?
      sorted_female_hash = female_hash.sort_by{|_, v| v}.reverse
      best_female = Dino.where(breed: breed, name: sorted_female_hash[0][0]).first
    end
    if male_hash.present?
      sorted_male_hash = male_hash.sort_by{|_, v| v}.reverse
      best_male = Dino.where(breed: breed, name: sorted_male_hash[0][0]).first
    end
    return [best_male, best_female]
  end

  def best_stats(breed)
    same_breed = Dino.dinos_by_breed(self, breed)
    max_health_object = self.max_health_dino(same_breed)
    counts_male = Hash.new(0)
    counts_female = Hash.new(0)
    if max_health_object.gender == 'Male' #### 1 if best health dino M, look for best stam
      best_health_dino = max_health_object ### 1
      females = same_breed.female_dinos ### 1
      best_stam_dino = self.max_stamina_dino(same_breed) ###
      if best_stam_dino == best_health_dino #### if stam dino is same as health dino
        counts_male[best_health_dino.name] += 2
        best_oxygen_dino = self.max_oxygen_dino(same_breed)
        if best_oxygen_dino == best_health_dino #### if oxygen dino is same as stam dino is same as health
          counts_male[best_health_dino.name] += 1 #### add to counts for health dino
        else
          counts_male[best_oxygen_dino.name] += 1
          best_oxygen_dino = self.max_oxygen_dino(females) #### if oxygen isnt same as health, stam
          counts_female[best_oxygen_dino.name] += 1
          best_food_dino = self.max_food_dino(same_breed)
          if best_food_dino == best_oxygen_dino
            counts_female[best_oxygen_dino.name] += 1
          elsif best_food_dino == best_health_dino
            counts_male[best_health_dino.name] += 1
          elsif best_food_dino.gender == 'Male'
            counts_male[best_food_dino.name] += 1
          end
        end
      elsif best_stam_dino.gender == 'Male'
        best_stam_dino = self.max_stamina_dino(females)
      end
      best_oxygen_dino = self.max_oxygen_dino(same_breed) #### 1 Look for all oxgen dinos
      if best_oxygen_dino == best_health_dino ####  2 if oxygen dino is health dino add to its count
        counts[best_health_dino.name] += 1 ### 2
        best_food_dino = self.max_food_dino(females) #### 2 if oxy dino is health dino find best food dino
        if best_food_dino == best_health_dino #### 3 if food dino is health dino add to health dino count
          counts[best_health_dino.name] += 1 ### 3
        end
      elsif best_oxygen_dino == best_stam_dino #### if oxygen dino is same as stam dino add to its count
        counts[best_stam_dino.name] += 1
      else

      end
    else
      ### if max health object is female
      best_health_dino = max_health_object
      males = same_breed.male_dinos
      best_stam_dino = self.max_stamina_dino(males)
      if best_stam_dino == best_health_dino

      end
    end
    max_oxygen_object = self.max_oxygen_dino(same_breed)
    max_food_object = self.max_food_dino(same_breed)
    max_weight_object = self.max_weight_dino(same_breed)
    max_melee_object = self.max_melee_dino(same_breed)


      return [counts_male, counts_female]
    end
  end

  def max_health_dino(dino_list)
    max_health_value = dino_list.maximum(:health)
    dino_list.find_by_health(max_health_value)
  end

  def max_stamina_dino(dino_list)
    max_stamina_value = dino_list.maximum(:stamina)
    dino_list.find_by_stamina(max_stamina_value)
  end

  def max_oxygen_dino(dino_list)
    max_oxygen_value = dino_list.maximum(:oxygen)
    dino_list.find_by_oxygen(max_oxygen_value)
  end

  def max_food_dino(dino_list)
    max_food_value = dino_list.maximum(:food)
    dino_list.find_by_food(max_food_value)
  end

  def max_weight_dino(dino_list)
    max_weight_value = dino_list.maximum(:weight)
    dino_list.find_by_weight(max_weight_value)
  end

  def max_melee_dino(dino_list)
    max_melee_value = dino_list.maximum(:melee)
    dino_list.find_by_melee(max_melee_value)
  end
end
