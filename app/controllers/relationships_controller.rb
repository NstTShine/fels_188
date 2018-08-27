class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    current_user.create_activity Activity.activity_types[:follow], user.id
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    current_user.create_activity Activity.activity_types[:unfollow], user.id
    redirect_to user
  end
end
