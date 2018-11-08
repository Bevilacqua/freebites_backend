class Post < ActiveRecord::Base
  belongs_to :user, required: true
  validates :title, presence: true
  validates :location, presence: true
end
