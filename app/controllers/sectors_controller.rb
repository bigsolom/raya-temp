class SectorsController < ApplicationController
  def new
  	@sector = Sector.new	
  end

  def create
  	@sector = Sector.new(sector_params)
  	if @sector.save
  		redirect_to :controller => "initiatives", :action => "new"
  	else
  	end
  end
end

private
def sector_params 
	params.require(:sector).permit(:image, :name, :description)
end
