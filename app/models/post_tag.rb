class PostTag < ApplicationRecord
  #タグ の関連付け
  belongs_to :post
  belongs_to :tag
  validates :tag_id, presence: true, uniqueness: { scope: :post_id }
end
