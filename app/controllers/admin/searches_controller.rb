class Admin::SearchesController < ApplicationController
  def search
    @keyword = params[:keyword]
    @users = User.where("name LIKE?", "%#{@keyword}%")
    @posts = Post.where("title LIKE?", "%#{@keyword}%")
  end
end
