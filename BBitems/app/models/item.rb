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

  #並び替え
  def self.sort(selection)
    case selection
    when 'new' #新しい順
      return all.order(created_at: :DESC)
    when 'old' #古い順
      return all.order(created_at: :ASC)
    when 'likes-many' #いいね多い順
      return find(Like.group(:item_id).order(Arel.sql('count(item_id) desc')).pluck(:item_id))
    when 'likes-few' #いいね少ない順
      return find(Like.group(:item_id).order(Arel.sql('count(item_id) asc')).pluck(:item_id))
    end
  end

end