class Category < ActiveHash::Base
  include ActiveHash::Associations
  has_many :restaurants
  self.data = [
    { id: 1, name: '居酒屋' }, { id: 2, name: 'カフェ' }, { id: 3, name: '和食' },
    { id: 4, name: '洋食' }, { id: 5, name: '中華' },
  ]
end
