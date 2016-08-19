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
    @new_comment = Comment.new

      if @comment.save
        CommentBroadcastJob.perform_later("create", @comment)
        flash.now[:success] = "You've created a new comment."
        # redirect_to topic_post_comments_path(@topic, @post, @comment)
      else
        flash.now[:danger] = @comment.errors.full_messages
        # redirect_to new_topic_post_path(@topic)
      end
  end

  def edit
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])

    # @comment = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))
  end

  def update
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    # @comments = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(comment_params)
      CommentBroadcastJob.perform_now("update", @comment)
      flash.now[:success] = "You've updated a comment!"
      # redirect_to topic_post_comments_path(@topic, @post)
    else
      flash.now[:danger] = @comment.errors.full_messages
      # redirect_to edit_topic_post_comment_path(@topic, @post)
    end
  end

  def destroy
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])
    authorize @comment

    if @comment.destroy
      CommentBroadcastJob.perform_now("destroy", @comment)
      flash.now[:success] = "You've deleted a comment!"
      # redirect_to topic_post_comments_path(@topic,@post)
    else
      flash.now[:danger] = @comment.errors.full_messages
      # redirect_to topic_post_comments_path(@topic, @post)
    end
  end

    private
      def comment_params
        params.require(:comment).permit(:body, :image)
      end

end
