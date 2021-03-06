class Genre < ApplicationRecord
  has_many :items

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }

end
