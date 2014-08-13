class HangoutsController < ApplicationController
  def create
  end

  def list
  	@initiatives = Initiative.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  	@sectors = Sector.all
  end

  def show
  	@initiative = Initiative.find_by_id(params[:id])
  end


end
