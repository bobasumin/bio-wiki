class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
    authorize! :read, Wiki, message: "You have to be signed-in."
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize! :read, @wiki, message: "You need to have a proper permission to read." 
    @users = User.all
    @user = @wiki.user
    @vote = Vote.new
  end

  def new
    @wiki = Wiki.new
    @user = current_user

    authorize! :create, Wiki
  end

  def create
    @wiki = current_user.build_wiki(params[:wiki])
    authorize! :create, @wiki, message: "You need to have a proper permission to create a Wiki."    
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving your Wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize! :edit, @wiki, message: "You need to own this Wiki to edit."
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize! :update, @wiki, message: "You need to own this Wiki to edit it."
    if @wiki.update_attributes(params[:wiki])
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize! :destroy, @wiki, message: "You need to own the wiki to delete."
    if @wiki.destroy
      flash[:notice] = "Your Wiki was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the Wiki."
      render :show
    end
  end
end
