class DinosController < ApplicationController
  def new
    @dino = Dino.new
  end

  def create
    @dino = Dino.new(dino_params)
    @tribe = Tribe.find_by_id(current_user.tribe_id)
    @dino.tribe = @tribe
    if @dino.save
      redirect_to tribe_path(@tribe)
    end
  end

  def breed_calc
    @tribe = Tribe.find_by_id(current_user.tribe.id)
    @best_dino_array = @tribe.opt_breed_pair(breed)
  end

  private

  def dino_params
    params.require(:dino).permit(:name, :health, :stamina, :oxygen, :food, :weight, :melee, :movement_speed,
                                 :level, :breed, :tribe_id, :gender)
  end

end
