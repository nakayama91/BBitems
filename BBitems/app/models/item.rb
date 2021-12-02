class Item < ApplicationRecord
  
  belongs_to :user
  belongs_to :genre
  
  attachment :profile_image
  
  validates :name, presence: true
  validates :introduction, presence: true
  
end
