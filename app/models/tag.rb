class Tag < ApplicationRecord
  #タグの関連付け
  has_many :post_tags, dependent: :destroy
end
