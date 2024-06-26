class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @post = Post.find(params[:id])
  end

  def index
    if params[:word].present?
      @posts = Post.where('title LIKE ?', "%#{params[:word]}%").page(params[:page])
    elsif params[:tag_id].present?
      @posts = Tag.find(params[:tag_id]).posts
      @posts = Kaminari.paginate_array(@posts).page(params[:page])
    else
      @posts = Post.page(params[:page])
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      flash[:notice] = "Successfully updated!"
      redirect_to admin_post_path(@post)
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
