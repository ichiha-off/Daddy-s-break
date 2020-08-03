class Reply < ApplicationRecord

  has_many :notifications, dependent: :destroy

  belongs_to :user
  belongs_to :comment

end
