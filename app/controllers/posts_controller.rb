class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    active = params[:active]
    expired = params[:expired]

    if(active && !expired)    # Only active posts
      @posts = Post.active
    elsif(!active && expired) # Only expired posts
      @posts = Post.expired
    else                      # Either both (or unspecified)
      @posts = Post.all
    end
  end

  def create
    if current_user.organization?
      post_params = params.permit(:title, :location, :description)
      post_params[:user_id] = current_user.id

      @post = Post.new(post_params)

      if @post.save
        render "posts/show", status: 201
      else
        render json: { status: 400, message: "Unable to create new post.", errors: validation_error(@post)}, status: :bad_request
      end
    else
      render json: { status: 403, message: "Only organizations may create new food posts." }, status: :forbidden
    end
  end

  def show
    if(params[:id].present?)
      @post = Post.find_by_id(params[:id])
      render json: { status: 404, message: "Post not found with id: #{params[:id]}" }, status: :not_found unless @post
    else
      render json: { status: 400, message: "Missing post id in request body." }, status: :bad_request
    end
  end
end
