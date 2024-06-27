class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:word].present?
      @tags = Tag.where('name LIKE ?', "%#{params[:word]}%").page(params[:page])
    else
      @tags = Tag.page(params[:page])
    end
  end
  
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end
end
