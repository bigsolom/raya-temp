class ResultsController < ApplicationController
  def index
	@results = Result.all
	@regions = Region.all
	@users = User.all
    	@results.each do |result|
     
     		@decisionmakers =  Decisionmaker.all.each do |decisionmaker|
     		decisionmaker = result.decisionmakers.where(decisionmaker_id = decisionmaker.id).all[0]
     		end
     	
    		@initiatives = Initiative.all.each do |initiative|
     		initiative = result.initiatives.where(initiative_id = initiative.id).all[0]
     		end
   	end
  end

  def create
	@initiatives = Initiative.all
	@decisionmakers = Decisionmaker.all
	@initiatives_ids = params[:initiatives_ids]
	@decisionmaker_ids = params[:decisionmaker_ids]
	result = Result.new
	if result = Result.new
		result.decision = params[:decision]
		if result.save
		redirect_to :action => "index"
	end
	end
	result.initiative_ids = @initiatives_ids
	result.decisionmaker_ids = @decisionmaker_ids
  end
end
