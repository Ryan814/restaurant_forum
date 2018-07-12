class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category
  delegate :name, to: :category, prefix:true, allow_nil: true
  #當restaurant刪除時，同時刪除相關的comment
  has_many :comments, dependent: :destroy
  #餐廳擁有許多收藏者
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  def prev
    Restaurant.where("id < ?", id).last
  end

  def next
    Restaurant.where("id > ?", id).first
  end
end
