class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def show
  end

  def index
  end

  def edit
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :music)
  end
end
