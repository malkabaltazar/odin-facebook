class CommentsController < ApplicationController
  before_action :author, only: :destroy

  def create
    current_user.comments.create(comment_params)
    redirect_back(fallback_location: posts_path)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back(fallback_location: posts_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:text, :post_id)
    end

    def author
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_back(fallback_location: posts_path) if @comment.nil?
    end
end
