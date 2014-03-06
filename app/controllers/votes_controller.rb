class VotesController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @section = @wiki.sections.find(params[:section_id])
    @vote = Vote.new

    authorize! :create, Vote
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @section = @wiki.sections.find(params[:section_id])
    @vote = current_user.votes.build(params[:vote])
    @vote.section = @section
    authorize! :create, @vote, message: "You cannot do that."
    
    if @vote.save
      flash[:notice] = "Voted"
      redirect_to @wiki
    else
      flash[:error] = "Unable to vote. Please try again."
      render :new
    end
  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:wiki_id])
    @vote = Vote.find(params[:id])
    if @vote.update_attributes(params[:vote])
      flash[:notice] = "Updated."
      redirect_to @wiki
    else
      flash[:error] = "Error"
      render :edit
    end
  end
end
