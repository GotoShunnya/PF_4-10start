class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def active_for_authentication? #is_drletedがtrueのユーザをはじく処理を作成
    super && (self.is_deleted == false) #is_deletedがfalseならtrueを返す
  end
end
