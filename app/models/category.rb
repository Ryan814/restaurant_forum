class Category < ApplicationRecord
validates_presence_of :name
validates_uniqueness_of :name

  #若分類中已經餐廳，則無法刪除分類
  has_many :restaurants, dependent: :restrict_with_error
end
