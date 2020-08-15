class Reply < ApplicationRecord

  has_many :notifications, dependent: :destroy
  belongs_to :re_reply,  class_name: "Reply", optional: true
  has_many   :re_replies, class_name: "Reply", foreign_key: :re_reply_id, dependent: :destroy

  attachment :image

  belongs_to :user
  belongs_to :comment

end
