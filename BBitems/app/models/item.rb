class Item < ApplicationRecord

  belongs_to :user
  belongs_to :genre

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :item_comments, dependent: :destroy

  attachment :image

  validates :name, presence: true
  validates :introduction, presence: true

  #いいねされているか確かめる為の定義
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
