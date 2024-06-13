class Post < ApplicationRecord
  
  #mount_uploader :music, AudiofileUploader #音声ファイルの取り込み
  has_one_attached :music
  has_one_attached :image #画像の取り込み
  
  belongs_to :user
  
  def get_image
    if image.attached?
      image
    else
      file_path = Rails.root.join('app/assets/images/noImage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
  end
end
