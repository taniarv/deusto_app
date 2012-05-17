class RelationshipsController < ApplicationController
  # Sólo los usuarios registrados pueden seguir a otros usuarios
  before_filter :login_required
  
  # Empezar a segir: follow
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  # Dejar de seguir: unfollow
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
