class Api::GroupsController < ApplicationController
  def index
    @groups = Group.find_by_sql("select groups.*
      FROM groups
      JOIN memberships on groups.id = memberships.group_id
      JOIN users on users.id = memberships.user_id
      WHERE users.id = #{User.first.id}")
  end


  def show
    @group = Group.find[params[:id]]
  end

  def create
    group = Group.new(group_params)
    if group.save
      Membership.create({group_id: group.id, user_id: 1})
      @groups = Group.find_by_sql("select groups.*
        FROM groups
        JOIN memberships on groups.id = memberships.group_id
        JOIN users on users.id = memberships.user_id
        WHERE users.id = #{User.first.id}")
      render :index
    else
      render json: group.errors.full_messages, status: 422
    end
  end

  def group_params
    params.require(:group).permit(:address, :token)
  end

end
