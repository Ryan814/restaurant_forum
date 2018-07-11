class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category
  delegate :name, to: :category, prefix:true, allow_nil: true
  #當restaurant刪除時，同時刪除相關的comment
  has_many :comments, dependent: :destroy

  def prev
    Restaurant.where("id < ?", id).last
  end

  def next
    Restaurant.where("id > ?", id).first
  end
end
