class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def show
  end

  def index
    @posts = Post.all
  end

  def edit
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :music)
  end
end
