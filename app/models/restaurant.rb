class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader

  def prev
    Restaurant.where("id < ?", id).last
  end

  def next
    Restaurant.where("id > ?", id).first
  end
end
