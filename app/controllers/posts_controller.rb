class PostsController < ApplicationController
  def index
    @posts = Post.all
    authorize! :read, Post, message: "You have to be signed-in."
  end

  def show
    @post = Post.find(params[:id])
    @users = User.all
    if request.path != post_path(@post)
      redirect_to @post, status: :moved_permanently
    end
    authorize! :read, @post, message: "You need to have a proper permission to read." 
  end

  def new
    @post = Post.new
    authorize! :create, Post
  end

  def create
    @post = current_user.posts.build(params[:post])

    authorize! :create, @post, message: "You need to have a proper permission to create a post."    
    if @post.save
      flash[:notice] = "Wiki was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving your Wiki. Please try again."
      redirect_to :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "You need to own this post to edit."
  end

  def update
    @post = Post.find(params[:id])
    authorize! :update, @post, message: "You need to own the post to edit it."
    if @post.update_attributes(params[:post])
      flash[:notice] = "Post was saved successfully."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    title = @post.title
    authorize! :destroy, @post, message: "You need to own the wiki to delete."
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end
end
