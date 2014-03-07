class FriendshipsController < ApplicationController

  def create  
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])  
    if @friendship.save  
      flash[:notice] = "Added friend."  
      redirect_to :back 
    else  
      flash[:notice] = "Unable to add friend."  
      render :back 
    end  
  end  

  def destroy
    binding.pry
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Cancelled friendship."
    redirect_to :back
  end

end
