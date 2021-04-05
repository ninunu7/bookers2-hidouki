class RelationshipsController < ApplicationController

  def create
    relationship = current_user.follow(params[:user_id])
    relationship.save
    redirect_back fallback_location: @user
  end

  def destroy
    relationship = current_user.unfollow(params[:user_id])
    relationship.destroy
    redirect_back fallback_location: @user
  end
end
