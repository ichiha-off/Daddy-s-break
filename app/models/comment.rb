class Comment < ApplicationRecord

  has_many :favorites, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :notifications, dependent: :destroy

  attachment :image

  belongs_to :topic
  belongs_to :user

  validates :comment, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
