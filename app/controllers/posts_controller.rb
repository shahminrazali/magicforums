class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
   @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
      if @post.save
        redirect_to posts_path
      else
        render new_posts_path
      end
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render edit_post_path(@post)
    end

  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    binding.pry
    if @post.destroy
      redirect_to posts_path
    else
      redirect_to post_path(@post)
    end
  end

  private
    def post_params
        params.require(:post).permit(:title, :body, :topic_id)
    end
end
