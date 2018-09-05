class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:friendship][:user])
    user.friendships.create(friend: current_user)
    current_user.friendships.create(friend: user)
    Notification.where(user_id: current_user.id, notifiable: user).destroy_all
    redirect_back(fallback_location: users_path)
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship2 = Friendship.where(user: friendship.friend, friend: friendship.user).first
    friendship.destroy
    friendship2.destroy
    redirect_back(fallback_location: users_path)
  end
end
