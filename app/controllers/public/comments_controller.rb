class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  before_action :is_matching_login_user, only: [:destroy]
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def ensure_guest_user
    if current_user.email == "guest@example"
      redirect_to request.referer, alert: 'You need to sign up!'
    end
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path
    end
  end
end
