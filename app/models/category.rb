class Category < ApplicationRecord

  has_many :topic

  validates :name, presence: true
  enum is_active: {"無効": 0, "有効": 1}

end
