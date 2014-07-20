class UsersController < ApplicationController
  def show
  	@user = User.find_by_id(params[:user_id])
  end

  def edit
  	@user = User.find_by_id(params[:user_id])
  	@name = params[:name]
   	@location = params[:location]
  	@job_title = params[:job_title]

  	if  @user.update_columns(:name => @name, :location => @location, :job_title => @job_title)
        #redirect_to :action => "show", :user_id => @user.id
      end
  end
  def follow
  	@user = User.find(params[:user_id])
  	current_user.follow!(@user)
  	redirect_to({controller: "initiatives", action: 'list'})
  end
  def unfollow
  	@user = User.find(params[:user_id])
  	current_user.unfollow!(@user)
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