class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @post = Post.find(params[:id])
  end

  def index
    if params[:word].present?
      @posts = Post.where('title LIKE ?', "%#{params[:word]}%")
    else
      @posts = Post.all
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Successfully updated!"
      redirect_to admin_posts_path
    else
      flash.now[:alert] = "Failed to update."
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :music)
  end
end
