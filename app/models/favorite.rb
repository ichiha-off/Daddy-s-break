class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :comment

  # 1ユーザーが1ブックスに対して1いいねしかできない制約（複数指定可能）
  validates_uniqueness_of :comment_id, scope: :user_id

end
