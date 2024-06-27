class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @room = Room.create
    @current_entry = @room.entries.create(user_id: current_user.id)
    @another_entry = @room.entries.create(user_id: params[:entry][:user_id])
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    if @room.entries.where(user_id: current_user.id).present?
      @messages = @room.messages.all
      @message = Message.new
      @entries = @room.entries
      #Roomで相手の名前表示するために記述
      @another_entry = @entries.where.not(user_id: current_user.id).first
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  def index
    #ログインユーザーの所属ルーム取得
    current_entries = current_user.entries
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    #自分のroom_idでuser_idが自分ではないものを取得
    @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: current_user.id).page(params[:page])
  end
end
