class Notification < ApplicationRecord

  default_scope -> { order(created_at: :desc) }
  belongs_to :topic, optional: true
  belongs_to :comment, optional: true
  belongs_to :reply, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  enum action: {"fav": 0, "comment": 1, "reply": 2, "follow": 3, "topic": 4}
  
end
