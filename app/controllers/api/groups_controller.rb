class Api::GroupsController < ApplicationController
  def index
<<<<<<< HEAD
    if current_user.landlord_id
      @groups = Group.where(landlord_id: current_user.id)
    else
      @groups = Group.where(tenant_id: current_user.id)
    end
  end

=======
    @groups = Group.find_by_sql("select groups.*
      FROM groups
      JOIN memberships on groups.id = memberships.group_id
      JOIN users on users.id = memberships.user_id
      WHERE users.id = #{User.first.id}")
  end


>>>>>>> origin/master
  def show
    @group = Group.find[params[:id]]
  end

  def create
<<<<<<< HEAD
    @group = Group.new()
    if current_user.landlord
      @group.landlord_id = current_user.id
    else
      @group.tenant_id = current_user.id
    end
      @group.token = SecureRandom.base64
    if @group.save
      render :show
=======
    group = Group.new(group_params)
    if group.save
      Membership.create({group_id: group.id, user_id: 1})
      @groups = Group.find_by_sql("select groups.*
        FROM groups
        JOIN memberships on groups.id = memberships.group_id
        JOIN users on users.id = memberships.user_id
        WHERE users.id = #{User.first.id}")
      render :index
>>>>>>> origin/master
    else
      render json: @group.errors.full_messages, status: 422
    end
  end

<<<<<<< HEAD
  def update
    @group = Group.find_by_token(params[:token])
    if current_user.landlord
      @group.update(landlord_id: current_user.id)
    else
      @group.update(tenant_id: current_user.id)
    end
    render :show
  end

  def group_params
    params.require(:group).permit(:id, :token)
=======
  # def update
  #   @group = Group.find_by_token(params[:token])
  #   if current_user.landlord
  #     @group.update(landlord_id: current_user.id)
  #   else
  #     @group.update(tenant_id: current_user.id)
  #   end
  #   render :show
  # end

  def group_params
    params.require(:group).permit(:address, :token)
>>>>>>> origin/master
  end

end
