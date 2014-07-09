class IndexController < ApplicationController
  def index
  	@initiatives = Initiative.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end
end
