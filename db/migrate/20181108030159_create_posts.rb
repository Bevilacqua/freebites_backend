class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.belongs_to :user, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
