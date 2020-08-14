class Topic < ApplicationRecord

  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :image
  
  belongs_to :user
  belongs_to :category

  is_impressionable counter_cache: true

end
