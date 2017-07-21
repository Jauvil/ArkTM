class TribesController < ApplicationController

  before_action :set_tribe, only: [:show, :update, :destroy, :tribe_request, :tribe_request_accept]
  before_action :set_r_user, only: [:tribe_request_accept, :tribe_request_decline]
  before_action :set_tribe_request, only: [:tribe_request_accept, :tribe_request_decline]

  def index
    @tribes = Tribe.all
  end

  def show
    @user = current_user
    @tribe_requests = TribeRequest.where(tribe_id: @tribe.id, status: 'active')
    @job_templates = JobTemplate.where(tribe_id: @tribe.id).all
  end

  def new
    @tribe = Tribe.new
  end

  def create
    @tribe = Tribe.new(tribe_params)
    @tribe.owner_id = current_user.id
    @tribe.users << current_user
    if @tribe.save
      redirect_to root_path
    else
      render action: 'new'
    end
  end

  def update

  end

  def tribe_request
    @user = current_user
    @tribe.tribe_join_request(@user)
  end

  def tribe_request_accept
    @tribe.add_user_via_request(@r_user, @tribe_request)
    redirect_to tribe_path(@tribe)
  end

  def tribe_request_decline
    @tribe_request.declined
    redirect_to tribe_path(@tribe)
  end


  def destroy

  end

  private
  def tribe_params
    params.require(:tribe).permit(:name, :owner_id)
  end

  def set_tribe
    @tribe = Tribe.find(params[:id])
  end

  def set_r_user
    @r_user = User.where(id: params[:user]).first
  end

  def set_tribe_request
    @tribe_request = TribeRequest.where(user_id: @r_user.id, tribe_id: @tribe.id).first
  end
end