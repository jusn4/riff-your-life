class Public::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      redirect_to room_path(message.room)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:body, :room_id)
  end
  
  private
  
  def ensure_guest_user
    if current_user.email == "guest@example"
      redirect_to request.referer, alert: 'You need to sign up!'
    end
  end
  
end
