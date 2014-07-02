class UsersController < ApplicationController
  def show
  	@user = User.find_by_id(params[:user_id])
  end

  def edit
  end
end

private
def user_params
  params.require(:user).permit(:image)
end
