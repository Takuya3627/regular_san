class Restaurant < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :restaurant
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :restaurant_comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 10 }
  validates :introduction, presence: true, length: { maximum: 95 }
  validates :image, presence: true
  validates :address, presence: true
  validates :home_page_url, presence: true
  validates :category_id, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  attachment :image

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
