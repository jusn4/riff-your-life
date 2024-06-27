class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  
  def create
    post = Post.find(params[:post_id])
    @favorite = current_user.favorites.new(post_id: post.id)
    @favorite.save
    render 'replace_fav'
  end
  
  def destroy
    post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: post.id)
    @favorite.destroy
    render 'replace_fav'
  end
  
  private
  
  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to request.referer, alert: 'You need to sign up!'
    end
  end
end
