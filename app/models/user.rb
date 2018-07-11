class User < ApplicationRecord
  #若使用者已經發表評論，則不允許刪除帳號
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  mount_uploader :avatar, AvatarUploader

  def admin?
    self.role == "admin"
  end
end
