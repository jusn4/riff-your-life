class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def index
    if params[:word].present?
      @users = User.where('name LIKE ?', "%#{params[:word]}%").page(params[:page])
    else
      @users = User.page(params[:page])
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Successfully updated!"
      redirect_to admin_user_path(@user)
    else
      flash.now[:alert] = "Failed to update."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
