class Types::PostsController < ApplicationController

  def show
    @type = Type.find(params[:type_id])
    authorize! :read, @type, message: "You need to have a proper permission to read."
    @post = Post.find(params[:id])
  end

  def new
    @type = Type.find(params[:type_id])
    @post = Post.new
    authorize! :create, Post
  end

  def create
    @type = Type.find(params[:type_id])
    @post = current_user.posts.build(params[:post])
    @post.type = @type

    authorize! :create, @post, message: "You need to have a proper permission to create a post."    
    if @post.save
      flash[:notice] = "Wiki was saved."
      redirect_to [@type, @post]
    else
      flash[:error] = "There was an error saving your Wiki. Please try again."
      redirect_to :new
    end
  end

  def edit
    @type = Type.find(params[:type_id])
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "You need to own this post to edit."
  end

  def update
    @type = Type.find(params[:type_id])
    @post = Post.find(params[:id])
    authorize! :update, @post, message: "You need to own the post to edit it."
    if @post.update_attributes(params[:post])
      redirect_to [@type, @post], notice: "Post was saved successfully."
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end
end
