class Comment < ApplicationRecord

  has_many :favorites, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :notifications, dependent: :destroy

  belongs_to :topic
  belongs_to :user

  validates :comment, presence: true

end
