class VotesController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @section = @wiki.sections.find(params[:section_id])

    authorize! :create, Vote, message: "You cannot do that."
    
    @vote = @section.votes.where(user_id: current_user.id).first

    if vote.valid?
      flash[:notice] = "Favorited post"
      redirect_to [@wiki]
    else
      flash[:error] = "Unable to add favorite. Please try again."
      redirect_to [@wiki]
    end
  end

  private

  def update_vote(new_value)
    if @vote
      @vote.update_attribute(:value, new_value)
    else
      @vote = current_user.votes.create(value: new_value, [ wiki: @wiki, section: @section ] )
    end
  end
end
