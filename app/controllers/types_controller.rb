class TypesController < ApplicationController
  def index
    @types = Type.all
  end

  def new
    @type = Type.new
    authorize! :create, @type, message: "You need to be admin to do that."
  end

  def create
    @type = Type.new(params[:type])
    authorize! :create, @type, message: "You need to be admin to do that."
    if @type.save
      redirect_to @type
    else
      flash[:error] = "Error saving type."
      render :new
    end
  end

  def show
    @type = Type.find(params[:id])
    authorize! :read, @type, message: "You don't have a proper permission."
    @posts = @type.posts
  end

  def edit
    @type = Type.find(params[:id])
    authorize! :update, @type, message: "You need to be admin to do that."
  end

  def update
    @type = Type.find(params[:id])
    authorize! :update, @type, message: "You need to be admin to do that."
    if @type.update_attributes(params[:type])
      redirect_to @type
    else
      flash[:error] = "Error updating type."
      render :edit
    end
  end
end
