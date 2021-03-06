class Post < ActiveRecord::Base
  belongs_to :user, required: true
  validates :title, presence: true
  validates :location, presence: true

  mount_base64_uploader :food_image, ImageUploader
  mount_base64_uploader :slip_image, ImageUploader

  scope :active,  ->   { where("created_at > ?", Time.now - 30.minutes) }
  scope :expired, ->   { where("created_at < ?", Time.now - 30.minutes) }

  def active?
    self.created_at > (Time.now - 30.minutes)
  end

  def time_left
    expiration_time = self.created_at + 30.minutes
    expiration_time - Time.now
  end

  def slip_uploaded?
    self.slip_image.url != ENV["DEFAULT_IMAGE_URL"]
  end
end
