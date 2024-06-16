class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :music
  has_one_attached :image

  validates :title, presence: true
  validates :music, presence: true, blob: { content_type: ['audio/mpeg', 'audio/x-wav', 'audio/flac'] }

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noImage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
