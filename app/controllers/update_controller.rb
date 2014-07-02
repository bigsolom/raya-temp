class UpdateController < ApplicationController
  def new
  	 @initiatives = current_user.initiatives.find(params[:initiative_id])
  	 @update = Update.new
  end

  def create
  	 update=Update.new(params[:update])
  	 update.action=params[:description]
  	 update.initiative_id=params[:id]
  	 if update.save
  	 	redirect_to(:controller => "initiatives",:action => 'show',:id => params[:id])
  	 else
  	    render('new')
   	 end
  end
end
