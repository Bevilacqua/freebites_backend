json.array! @posts do |post|
  json.id         post.id
  json.title      post.title
  json.location   post.location
  json.created_at post.created_at
  json.active     post.active?
  json.time_left  post.time_left
end
