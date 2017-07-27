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
    best_dinos_array = self.best_stats(breed)
    compiled_stats = best_dinos_array.group_by(&:first).map { |k, vs| [k, vs.map(&:last)]}
    sorted_cs = compiled_stats.sort_by(&:size).reverse
    dino_1_a = sorted_cs.shift
    dino_1 = dino_1_a[0]
    i = 0
    while i < sorted_cs.count
      dino_2_a = sorted_cs.shift
      dino_2 = dino_2_a[0]
      if dino_2.gender != dino_1.gender
        return [dino_1, dino_2]
      end
      i =+ 1
    end
  end

  def best_stats(breed)
    same_breed = Dino.dinos_by_breed(self, breed)
    health = self.max_health_dino(same_breed)
    stamina = self.max_stamina_dino(same_breed)
    oxygen = self.max_oxygen_dino(same_breed)
    food = self.max_food_dino(same_breed)
    weight = self.max_weight_dino(same_breed)
    melee = self.max_melee_dino(same_breed)
    [health, stamina, oxygen, food, weight, melee]
  end

  def max_health_dino(dino_list)
    max_health_value = dino_list.maximum(:health)
    return [dino_list.find_by_health(max_health_value), "1 health"]
  end

  def max_stamina_dino(dino_list)
    max_stamina_value = dino_list.maximum(:stamina)
    return [dino_list.find_by_stamina(max_stamina_value), "3 stamina"]
  end

  def max_oxygen_dino(dino_list)
    max_oxygen_value = dino_list.maximum(:oxygen)
    return [dino_list.find_by_oxygen(max_oxygen_value), "6 oxygen"]
  end

  def max_food_dino(dino_list)
    max_food_value = dino_list.maximum(:food)
    return [dino_list.find_by_food(max_food_value), "5 food"]
  end

  def max_weight_dino(dino_list)
    max_weight_value = dino_list.maximum(:weight)
    return [dino_list.find_by_weight(max_weight_value), "4 weight"]
  end

  def max_melee_dino(dino_list)
    max_melee_value = dino_list.maximum(:melee)
    return [dino_list.find_by_melee(max_melee_value), "2 melee"]
  end
end
