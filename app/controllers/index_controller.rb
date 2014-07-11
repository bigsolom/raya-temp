class IndexController < ApplicationController
  def index
  	if params[:friends_ids]
      @initiatives = []
      @users = current_user.followed_users
      @users.each do |user|
        initiatives = Initiative.where("user_id" => user.id)
        initiatives.each do |initiative|
          @initiatives.push(initiative)
        end
      end
      @initiatives = @initiatives.sort_by {|obj| obj.created_at}.reverse.paginate(:page => params[:page], :per_page => 5)
      @friend_initiative = true
  	else
  	@initiatives = Initiative.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  	end
  end
end
