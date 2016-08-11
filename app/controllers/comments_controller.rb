class CommentsController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comments = @post.comments.order("created_at ASC")
    @comment = Comment.new
  end

  # def new
  #   @topic = Topic.find_by(id: params[:topic_id])
  #   @post = Post.find_by(id: params[:post_id])
  #   @comment = Comment.new
  # end

  def create
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))

      if @comment.save
        flash[:success] = "You've created a new comment."
        redirect_to topic_post_comments_path(@topic, @post, @comment)
      else
        flash[:danger] = @post.errors.full_messages
        redirect_to new_topic_post_path(@topic)
      end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
  def comment_params
    params.require(:comment).permit(:body, :image)
  end

end
