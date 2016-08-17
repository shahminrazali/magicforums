class TopicsController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.new
    @topics = Topic.order(:created_at).page params[:page]
  end

  # def show
  #   @topic = Topic.find_by(id: params[:id])
  #   # binding.pry
  # end

  # def new
  #   @topic = Topic.new
  #   authorize @topic
  # end

  def create
    @topic = current_user.topics.build(topic_params)
    authorize @topic
    @new_topic = Topic.new

    if @topic.save
      flash.now[:success] = "You've created a new topic."
      # redirect_to topics_path
    else
      flash.now[:danger] = @topic.errors.full_messages
      # render new_topic_path
    end
  end

  def edit
    @topic = Topic.find_by(id: params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find_by(id: params[:id])
    authorize @topic

    if @topic.update(topic_params)
      flash.now[:success] = "You've updated this topic."
      # redirect_to topics_path(@topic)
    else
      flash.now[:danger] = @topic.errors.full_messages
      # redirect_to edit_topic_path(@topic)
    end
  end

  def destroy
    @topic = Topic.find_by(id: params[:id])
    authorize @topic
    # @posts = @topic.posts
    #
    # @posts.each do |post|
    #   post.destroy
    #   comments = post.comments
    #
    #   comments.each do |comment|
    #     comment.destroy
    #   end
    # end

    if @topic.destroy
      flash.now[:success] = "You've deleted" + @topic_params.to_s
      # redirect_to topics_path
    else
      flash.now[:danger] = @topic.errors.full_messages
      # redirect_to topic_path(@topic)
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :description)
  end

end
