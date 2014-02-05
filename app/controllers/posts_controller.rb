class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = "Wiki was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving your Wiki. Please try again."
      redirect_to :new
    end
  end

  def edit
  end
end
