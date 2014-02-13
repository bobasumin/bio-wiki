class CollaborationsController < ApplicationController
  def index
    @shared_posts = current_user.shared_posts
  end
end
