class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @received = current_user.notifications.where(notifiable_type: "User")
    @sent = Notification.where(notifiable: current_user)
    exclude = @sent.all.map(&:user_id) + @received.all.map(&:notifiable_id)
    exclude += current_user.friendships.map(&:friend_id)
    exclude.push(current_user.id)
    @users = User.where("id NOT IN (?)", exclude)
    @notification = Notification.new
    @friendship = Friendship.new
  end

  def show
    if params[:id] == "sign_out"
      sign_out current_user
      redirect_to root_path
    else
      @user = User.find(params[:id])
      @friends = @user.friends
      @notification = Notification.new
      @friendship = Friendship.new
    end
  end
end
