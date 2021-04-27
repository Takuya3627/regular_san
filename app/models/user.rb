class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_many :restaurants, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_restaurants, through: :favorites, source: :restaurant
  has_many :restaurant_comments, dependent: :destroy
  attachment :profile_image
end
