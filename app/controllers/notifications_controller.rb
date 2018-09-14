class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def create
    user = User.find(params[:notification][:user])
    user.notifications.create(notifiable: current_user)
  end

  def destroy
    Notification.find(params[:id]).destroy
    redirect_back(fallback_location: posts_path)
  end
end
