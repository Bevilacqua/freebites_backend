json.active do
  json.array! @active_posts do |post|
    json.id           post.id
    json.title        post.title
    json.location     post.location
    json.created_at   post.created_at
    json.active       post.active?
    json.time_left    post.time_left
    json.food_image   post.food_image.url
    json.slip_present post.slip_uploaded?
  end
end

json.expired do
  json.array! @expired_posts do |post|
    json.id           post.id
    json.title        post.title
    json.location     post.location
    json.created_at   post.created_at
    json.active       post.active?
    json.food_image   post.food_image.url
    json.slip_present post.slip_uploaded?
  end
end
