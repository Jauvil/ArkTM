class TribesController < ApplicationController

  before_action :set_tribe, only: [:show, :update, :destroy, :tribe_request, :tribe_request_accept]
  before_action :set_r_user, only: [:tribe_request_accept, :tribe_request_decline]

  def index
    @tribes = Tribe.all
  end

  def show
    @tribe_requests = TribeRequest.where(tribe_id: @tribe.id, status: 'active')
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
    @tribe.users << @r_user
    @tribe.save
    @tribe_request = TribeRequest.where(user_id: @r_user.id, tribe_id: @tribe.id).first
    @tribe_request.status = 'accepted'
    @tribe_request.save
    redirect_to tribe_path(@tribe)
  end

  def tribe_request_decline
    @tribe_request = TribeRequest.where(user_id: @r_user.id, tribe_id: @tribe.id).first
    @tribe_request.status = 'declined'
    @tribe_request.save
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
end