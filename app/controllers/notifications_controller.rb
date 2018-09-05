class NotificationsController < ApplicationController
  def create
    user = User.find(params[:notification][:user])
    user.notifications.create(notifiable: current_user)
  end

  def destroy
    Notification.find(params[:id]).destroy
    redirect_back(fallback_location: users_path)
  end
end
