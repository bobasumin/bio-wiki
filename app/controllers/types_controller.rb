class TypesController < ApplicationController
  def index
    @types = Type.all
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(params[:type])
    if @type.save
      redirect_to @type
    else
      flash[:error] = "Error saving type."
      render :new
    end
  end

  def show
    @type = Type.find(params[:id])
    @posts = @type.posts
  end

  def edit
    @type = Type.find(params[:id])
  end

  def update
    @type = Type.find(params[:id])
    if @type.update_attributes(params[:type])
      redirect_to @type
    else
      flash[:error] = "Error updating type."
      render :edit
    end
  end
end
