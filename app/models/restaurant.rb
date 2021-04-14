class Restaurant < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :restaurant
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :restaurant_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  attachment :image

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
