class Api::MembershipsController < ApplicationController
  def create
    id = Group.find_by_token(params[:token]).id
    membership = Membership.new(group_id: id)
    membership.user_id = current_user.id
    if membership.save
      render 'api/groups/index'
    else
      render json: membership.errors.full_messages, status: 422
    end
  end
end
