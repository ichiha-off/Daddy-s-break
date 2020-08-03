class Notification < ApplicationRecord

  default_scope -> { order(created_at: :desc) }
  belongs_to :topic, optional: true
  belongs_to :comment, optional: true
  belongs_to :reply, optional: true

  belongs_to :vistor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visted, class_name: 'User', foreign_key: 'visited_id', optional: true
  
end
