class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items,         dependent: :destroy
  has_many :item_comments, dependent: :destroy
  has_many :likes,         dependent: :destroy

  # 自分がフォローする（与フォロー）側の関係性（userはたくさんの人をフォローしている）
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  # 自分がフォローされる（被フォロー）側の関係性（userはたくさんの人にフォローされている）
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  attachment :profile_image

  validates :name, presence: true,  length: { maximum: 20 }, uniqueness: true

end
