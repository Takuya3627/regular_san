class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.text :introduction
      t.string :image_id
      t.string :address
      t.string :home_page_url

      t.timestamps
    end
  end
end
