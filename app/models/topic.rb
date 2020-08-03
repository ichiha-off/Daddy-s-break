class Topic < ApplicationRecord

  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :user
  belongs_to :category

end
