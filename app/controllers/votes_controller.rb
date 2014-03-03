class VotesController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @section = @wiki.sections.find(params[:section_id])
    @vote = Vote.new

    authorize! :create, Vote, message: "You cannot do that."
    
    if @vote.save
      flash[:notice] = "Voted"
      redirect_to [@wiki]
    else
      flash[:error] = "Unable to vote. Please try again."
      redirect_to [@wiki]
    end
  end

  #def update
  #  if @vote
  #    @vote.update_attribute(:value, new_value)
  #  else
  #    @vote = current_user.votes.create(value: new_value, [ wiki: @wiki, section: @section ] )
  #  end
  #end
end
