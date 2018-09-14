class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :author, only: :destroy

  def index
    @posts = current_user.feed
    @post = Post.new
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.create(post_params)
    redirect_back(fallback_location: posts_path)
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_back(fallback_location: posts_path)
  end

  private

    def post_params
      params.require(:post).permit(:text)
    end

    def author
      @post = current_user.posts.find_by(id: params[:id])
      redirect_back(fallback_location: posts_path) if @post.nil?
    end
end
