class Post < ApplicationRecord
  #ユーザーとの関連付け
  belongs_to :user
  #コメントの関連付け
  has_many :comments, dependent: :destroy
  #いいねとの関連付け
  has_many :favorites, dependent: :destroy
  #タグの関連付け
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_one_attached :music
  has_one_attached :image

  validates :title, presence: true
  validates :music, presence: true, blob: { content_type: ['audio/mpeg', 'audio/x-wav', 'audio/flac'] }

  scope :latest, -> {order(created_at: :desc)}

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noImage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_tags(tags)
    #タグが存在していれば、タグの名前を配列としてすべて取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    #取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    #送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    #古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    #新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end

end
