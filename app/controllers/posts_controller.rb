class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_posts = Post.active
    @expired_posts = Post.expired.order("created_at DESC").limit(5) # Ordered to show the most recently expired items
  end

  def create
    if current_user.organization?
      post_params = params.permit(:title, :location, :description, :food_image, :slip_image)
      puts post_params
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

  def destroy
    if(params[:id].present?)
      @post = Post.find_by_id(params[:id])
      if !@post
        render json: { status: 404, message: "Post not found with id: #{params[:id]}" }, status: :not_found
      elsif current_user.id != @post.user.id
        render json: { status: 403, message: "Current user does not own the post with id: #{params[:id]}" }, status: :forbidden
      elsif @post.destroy
        head :no_content
      else
        render json: { status: 500, message: "Unkown error in destroying post with id: #{params[:id]}"}, status: :internal_server_error
      end
    else
      render json: { status: 400, message: "Missing post id." }, status: :bad_request
    end
  end
end
