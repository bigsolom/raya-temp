class UsersController < ApplicationController
  def show
  	@piro = params[:user_id]
  	@user = User.find_by_id(params[:user_id])
  end

  def edit
  end
end
