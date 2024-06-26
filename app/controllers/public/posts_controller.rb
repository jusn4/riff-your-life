class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:new, :create, :edit, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    #受け取った値を,で区切って配列にする
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tags(tag_list)
      flash[:notice] = "Successfully posted!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Failed to post."
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def following
    if params[:word].present?
      @posts = Post.where('title LIKE ?', "%#{params[:word]}%").page(params[:page])
    elsif params[:latest].present?
      @posts = Post.latest.page(params[:page])
    elsif  params[:fav_count].present?
      @posts = Post.sort {|a,b|
        b.favorites.size <=>
        a.favorites.size
      }
      @posts = Kaminari.paginate_array(@posts).page(params[:page])
    else
      @posts = Post.where(user_id: [*current_user.following_ids]).page(params[:page])
    end
  end


  def index
    if params[:word].present?
      @posts = Post.where('title LIKE ?', "%#{params[:word]}%").page(params[:page])
    elsif params[:tag_id].present?
      @posts = Tag.find(params[:tag_id]).posts.page(params[:page])
    elsif params[:latest].present?
      @posts = Post.latest.page(params[:page])
    elsif  params[:fav_count].present?
      @posts = Post.all.sort {|a,b|
        b.favorites.size <=>
        a.favorites.size
      }
      @posts = Kaminari.paginate_array(@posts).page(params[:page])
    else
      @posts = Post.page(params[:page])
    end
  end

  def favorites
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @posts = Post.find(favorites)
    @posts = Kaminari.paginate_array(@posts).page(params[:page])
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
      redirect_to mypage_path
    else
      flash.now[:alert] = "Failed to update."
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to mypage_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :music)
  end

  def ensure_guest_user
    if current_user.email == "guest@example"
      redirect_to mypage_path, alert: 'You need to sign up!'
    end
  end

  def is_matching_login_user
    @posts = current_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to mypage_path unless @post
  end
end
