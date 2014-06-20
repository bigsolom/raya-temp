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
    logger.debug "New: #{@initiative.attributes.inspect}"
    respond_to do |format|
      if @initiative.save
        format.html { redirect_to @initiative, notice: 'Initiative was successfully created.' }
      else
        format.html { render :new }
      end
    end
    update=Update.new(params[:update])
    update.action=params[:description]
    update.initiative_id=params[:initiative_id].to_i
    if update.save
      redirect_to(:action => 'update')
    else
      render('new')
    end
  end

  def show
    @initiative = Initiative.find(params[:id])
    @updates = Update.where(initiative_id: params[:id])
    @comments = Comment.where("commentable_id" => params[:id]).where("commentable_type" => "initiative")
    #@results=@initiative.results
    if request.get?
      users=@initiative.users 
      if users.exists?(1)
        userFlag =users.find(1)
        if userFlag == []
          user = User.find(1)
          user.initiatives << @initiative
        else
          @status = "You already support this initiative."
        end
      else
        user = User.find(1)
        user.initiatives << @initiative
      end
    end
  end 


end


private
def initiative_params
  params.require(:initiative).permit(:title, :description, :region_id, :user_id, :image, :tags, :sector_id)
end
