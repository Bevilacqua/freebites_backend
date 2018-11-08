json.(@post, :id, :title, :description, :location, :created_at, :updated_at)

json.user do
  json.id @post.user.id
  json.email @post.user.email
end
