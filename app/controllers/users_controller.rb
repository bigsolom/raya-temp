class UsersController < ApplicationController
  def show
  	@user = User.find_by_id(params[:user_id])
  end

  def edit
  end
  def create_relation
  	@user = User.find(params[:user_id])
  	current_user.follow!(@user)
  	redirect_to({controller: "initiatives", action: 'list'})
  end
  def list
  	@users = current_user.followed_users 
  end
end

private
def user_params
  params.require(:user).permit(:image)
end
