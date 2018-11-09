class AddSlipImageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slip_image, :string
  end
end
