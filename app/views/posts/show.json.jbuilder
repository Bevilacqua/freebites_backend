json.(@post, :id, :title, :description, :location, :created_at, :updated_at)
json.active     @post.active?
json.time_left  @post.time_left

json.user do
  json.id @post.user.id
  json.email @post.user.email
end
