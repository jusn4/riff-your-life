class Comment < ApplicationRecord
  #ユーザーの関連付け
  belongs_to :user
  #投稿の関連付け
  belongs_to :post
end
