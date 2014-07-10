class UsersController < ApplicationController
  def show
  	@user = User.find_by_id(params[:user_id])
  end

  def edit
  	@user = User.find_by_id(params[:user_id])
  	@name = params[:name]
  	@email = params[:email]
  	@date_of_birth = params[:date_of_birth]
  	@gender = params[:gender]
  	@national_id = params[:national_id]
  	@location = params[:location]
  	@job_title = params[:job_title]

  	@user.update_attributes(:name => @name, :email => @email, :date_of_birth => @date_of_birth, :gender => @gender, :national_id => @national_id, :location => @location, :job_title => @job_title)
  #redirect_to :action => "show"
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