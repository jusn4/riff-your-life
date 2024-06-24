class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @user = current_user
    @posts = @user.posts
  end
  
  def index
    if params[:word].present?
      @users = User.where('name LIKE ?', "%#{params[:word]}%")
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Successfully updated!"
      redirect_to mypage_path
    else
      flash.now[:alert] = "Failed to update."
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
  
  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to mypage_path, alert: 'You need to sign up!'
    end
  end 

end
