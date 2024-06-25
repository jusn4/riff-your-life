class PostTag < ApplicationRecord
  #タグ の関連付け
  belongs_to :post
  belongs_to :tag
  #validatesを入れることで重複を防ぐ
  validates :post_id, presence: true
  validates :tag_id, presence: true
end
