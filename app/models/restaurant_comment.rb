class RestaurantComment < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :comment, presence: true
  validates :rate, presence: true

end
