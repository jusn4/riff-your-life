class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:word].present?
      @tags = Tag.where('name LIKE ?', "%#{params[:word]}%")
    else
      @tags = Tag.all
    end
  end
  
   def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to tags_path
  end
end
