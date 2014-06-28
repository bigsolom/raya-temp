class SupportsController < ApplicationController
  def support
@initiative = Initiative.find(params[:initiative_id])
    if request.get?
      users=@initiative.users 
      if users.exists?(current_user.id)
        userFlag =users.find(current_user.id)
        if userFlag == []
          user = User.find(current_user.id)
          user.initiatives << @initiative

        else
        @status = 1
        end
      else
        user = User.find(current_user.id)
        user.initiatives << @initiative

      end
    end
    redirect_to :controller => "initiatives", :action => "show", :id =>params[:initiative_id]
      end 
end

