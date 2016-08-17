class PostsController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).find_by(id: params[:topic_id])
    @posts = @topic.posts.order("created_at DESC")
    @post = Post.new
  end

  # def show
  #  @post = Post.find_by(id: params[:id])
  # end

  # def new
  #   @topic = Topic.find_by(id: params[:topic_id])
  #   @post = Post.new
  # end

  def create
    # @topic = current_user.topics.build(topic_params)
    @topic = Topic.find_by(id: params[:topic_id])
    @post = current_user.posts.build(post_params.merge(topic_id: params[:topic_id]))
    @new_post = Post.new

      if @post.save
        flash.now[:success] = "You've created a new post."
        # redirect_to topic_posts_path(@topic)
      else
        flash.now[:danger] = @post.errors.full_messages
        # redirect_to new_topic_post_path(@topic)
      end
  end

  def update
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:id])

    if @post.update(post_params)
      flash.now[:success] = "You've updated a post."
      # redirect_to topic_posts_path(@topic)
    else
      flash.now[:danger] = @post.errors.full_messages
      # redirect_to edit_topic_post_path(@topic, @post)
    end

  end

  def edit
    @post = Post.find_by(id: params[:id])
    @topic = @post.topic
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @topic = @post.topic

    if @post.destroy
      flash[:success] = "Post deleted!"
      # redirect_to topic_posts_path(@topic)
    else
      flash[:danger] = @post.errors.full_messages
      # redirect_to topic_posts_path(@topic)
    end
  end

  private
    def post_params
        params.require(:post).permit(:title, :body, :image)
    end
end
