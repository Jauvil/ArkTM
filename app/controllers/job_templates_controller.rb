class JobTemplatesController < ApplicationController

  def new
    @job_template = JobTemplate.new
  end

  def create
    @job_template = JobTemplate.new(job_params)
    @job_template.tribe_id = current_user.tribe_id
    @tribe = Tribe.find(current_user.tribe_id)
    if @job_template.save
      redirect_to tribe_path(@tribe)
    else
    render 'new'
    end
  end

  private

  def job_params
    params.require(:job_template).permit(:name, :description, :tribe_id)
  end

end
