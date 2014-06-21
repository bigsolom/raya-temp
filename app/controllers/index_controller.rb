class IndexController < ApplicationController
  def index
  	@initiatives = Initiative.all
  end
end
