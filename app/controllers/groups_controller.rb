class GroupsController < ApplicationController

  def show
    @group = Group.find_by_id(params[:id])
  end
  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(create_group_params)
    if @group
      Membership.create({user: current_user, group: @group})
    end
    redirect_to '/groups', notice: "Created"
  end

  def search
    if params[:query]
      @groups = Group.where("name ilike ?", "%#{params[:query]}%")
    end
  end

  private

  def create_group_params
    params.require(:group).permit(:name, :visibility_type, :join_type, :passcode)
  end
end
