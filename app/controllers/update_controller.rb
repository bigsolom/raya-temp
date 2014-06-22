class UpdateController < ApplicationController
  def new
  	 @initiatives = Initiative.all
  	 @initiatives_ids = params[:initiatives_ids]
  	 @update = Update.new
  end

  def create
  	 update=Update.new(params[:update])
  	 update.action=params[:description]
  	 update.initiative_id=params[:initiative_id]
  	 if update.save
  	 	redirect_to(:action => 'new')
  	 else
  	    render('new')
   	 end
  end
end
