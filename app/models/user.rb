class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable

	validates :name, length: {maximum: 10, minimum: 2}, uniqueness: true
	validates :introduction, length: {maximum: 50}

	enum :is_active {"無効": 0, "有効": 1}

	has_many :topics, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :replies, dependent: :destroy
	has_many :favorites, dependent: :destroy

	has_many :following, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy # フォロー取得
	has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
	has_many :following_user, through: :following, source: :followed # 自分がフォローしている人
	has_many :follower_user, through: :followed, source: :following # 自分をフォローしている人

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

end
