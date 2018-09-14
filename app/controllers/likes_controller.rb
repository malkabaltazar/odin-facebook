class LikesController < ApplicationController
  before_action :author, only: :destroy

  def index
    @users = Post.find(params[:post_id]).likes.all.map(&:user)
    @notification = Notification.new
  end

  def create
    current_user.likes.create(post_id: params[:post_id])
    redirect_back(fallback_location: posts_path)
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_back(fallback_location: posts_path)
  end

  private

    def author
      @like = current_user.likes.find_by(id: params[:id])
      redirect_back(fallback_location: posts_path) if @like.nil?
    end
end
