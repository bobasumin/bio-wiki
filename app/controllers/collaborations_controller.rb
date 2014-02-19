class CollaborationsController < ApplicationController
  def index
    @shared_wikis = current_user.shared_wikis
  end
end
