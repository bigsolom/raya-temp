class SurvaysController < ApplicationController
def new
	@initiative = Initiative.find(params[:initiative_id])
	@initiative_id = params[:initiative_id]
	@survay = Survay.new()

end
def create
	@initiative_id = params[:initiative_id]
	@initiative = Initiative.find(params[:initiative_id])
	@survay = Survay.new(survay_params)
	if @survay.save
		@initiative.survays << @survay
			redirect_to(:controller => 'initiatives',:action => 'show', :id => @initiative_id )
	else 
      render('new')
    end
end



private
def survay_params
  params.require(:survay).permit(:question, :initiative_id)
end
end