class Favorite < ApplicationRecord
  #ユーザーとの関連付け
  belongs_to :user
  #ポストとの関連付け
  belongs_to :post
end
