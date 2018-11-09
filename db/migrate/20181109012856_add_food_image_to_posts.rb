class AddFoodImageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :food_image, :string
  end
end
