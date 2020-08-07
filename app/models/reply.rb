class Reply < ApplicationRecord

  has_many :notifications, dependent: :destroy

  attachment :image

  belongs_to :user
  belongs_to :comment

end
