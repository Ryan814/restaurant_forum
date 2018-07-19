class User < ApplicationRecord
  #若使用者已經發表評論，則不允許刪除帳號
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments
  
  #「使用者能收藏很多餐廳」的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  
  #使用者能喜歡多間餐廳
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  #使用者能追蹤很多人也能被多人追蹤
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  mount_uploader :avatar, AvatarUploader

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
end
