class CreateRestaurantComments < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_comments do |t|
      t.float :rate
      t.text :comment
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
