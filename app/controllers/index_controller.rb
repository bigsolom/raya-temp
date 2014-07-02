class IndexController < ApplicationController
  def index
  	@initiatives = Initiative.all.order('created_at DESC')
  end
end
