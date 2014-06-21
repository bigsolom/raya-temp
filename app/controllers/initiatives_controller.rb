class InitiativesController < ApplicationController
  def index
  end

  def list
    @sectors = Sector.all
    case 
    when params[:searchTitle]
      @initiatives = Initiative.searchTitle(params[:searchTitle])
    when params[:tag]
      @initiatives = Initiative.tagged_with(params[:tag])
    when params[:searchRegion]
      @initiatives = Initiative.searchRegion(params[:searchRegion])
    else
      @initiatives = Initiative.all
    end
    @initiatives =Initiative.all
    
  end
  
  def new
    @initiative = Initiative.new
    @sectors = Sector.all
    @regions = Region.all.collect{|region| [region.name, region.id]}
  end
  
  def update
   @initiatives = Initiative.all
   @initiatives_ids = params[:initiatives_ids]
   @update = Update.new
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
  
    respond_to do |format|
      if @initiative.save
        format.html { redirect_to @initiative, notice: 'Initiative was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @initiative = Initiative.find(params[:id])
    @updates = Update.where(initiative_id: params[:id])
    @comments = Comment.where("commentable_id" => params[:id]).where("commentable_type" => "initiative")
    #@results=@initiative.results

  end 


end


private
def initiative_params
  params.require(:initiative).permit(:title, :description, :region_id, :user_id, :image, :tags, :sector_id)
end
