class InitiativesController < ApplicationController
  def index
  end
  def list
    @sectors = Sector.all
    @initiatives =Initiative.all
  end
  def new
    @initiative = Initiative.new
    @sectors = Sector.all
    @regions = Region.all.collect{|region| [region.name, region.id]}
  end
  def create
    @initiative = Initiative.new(initiative_params)
    tags = params[:tags]
    @tags = tags.split(",")
    @tags.each do |tag|
      if Tag.find_by_name(tag)
        
      else
        
      end
    end
    logger.debug "New: #{@initiative.attributes.inspect}"
    respond_to do |format|
      if @initiative.save
        format.html { redirect_to @initiative, notice: 'Initiative was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @initiative = Initiative.find(1)
  end
end

private
def initiative_params
  params.require(:initiative).permit(:title, :description, :region_id, :user_id, :image, :tags, :sector_id)
end
