class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @user = current_user
    @posts = @user.posts.page(params[:page])
  end
  
  def index
    if params[:word].present?
      @users = User.where('name LIKE ?', "%#{params[:word]}%").page(params[:page])
    else
      @users = User.page(params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    #roomがcreateされたときにcurrent_userと相手の両方をentriesテーブルから取得
    @posts = @user.posts.page(params[:page])
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      #entryテーブル内に同一room_idを調べる
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @is_room
        #同一テーブルがない場合は新しく作成
        @room = Room.new
        @entry = Entry.new
      end
    end
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
