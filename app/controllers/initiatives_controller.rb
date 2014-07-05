class InitiativesController < ApplicationController
  def index
  end

  def list
    @sectors = Sector.all

    if params[:searchTitle]
      @initiatives = Initiative.searchTitle(params[:searchTitle]).order('created_at DESC')
    elsif params[:region_name]
      @initiatives = Initiative.searchRegion(params[:region_name]).order('created_at DESC')
    elsif params[:user_id]
      @initiatives = Initiative.searchUser(params[:user_id]).order('created_at DESC')
    elsif params[:sector_name]
      @initiatives = Initiative.searchSector(params[:sector_name]).order('created_at DESC')
    elsif params[:tag]
      @initiatives = Initiative.tagged_with(params[:tag]).order('created_at DESC') 
    elsif params[:search_all]
      @initiatives = Initiative.searchAll(params[:search_all]).order('created_at DESC')
    else
      @initiatives = Initiative.all.order('created_at DESC')

    end
    
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
    
    #Tags
    tags = params[:tags]
    @tags = tags.split(",")
    @tags.each do |tag|
    
      #each tag
        @test_tag = Tag.find_by_name(tag)
        if !(@test_tag) #not exists
          @new_tag = Tag.new
          @new_tag.name = tag
          @new_tag.save
        else
          @new_tag = @test_tag
        end
         @initiative.tags << @new_tag

    end

    respond_to do |format|
      if @initiative.save
        format.html { redirect_to @initiative }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @initiative = Initiative.find(params[:id])
    @updates = Update.where(initiative_id: params[:id]).order('created_at DESC')
    @comments = Comment.where("commentable_id" => params[:id]).where("commentable_type" => "initiative")
    @results=@initiative.results
    
    #support initiative
    @supoorters = @initiative.users.length
    @support_percent = ((45000/45000)*100)
    
    users=@initiative.users
    if users.exists?(current_user.id)
      @supportFlag =users.find(current_user.id)
    else
      @supportFlag=[]
    end  

    
    ## POLL Existance & Voted TEST##
    @poll_exist = false
    @user_voted_before = false
    @users_who_voted_for_ans_question = []

    if Poll.where(initiative_id: params[:id]).last

      @poll_exist = true
      
      @poll = Poll.where(initiative_id: params[:id]).last
      question_of_answer = @initiative.polls.last.questions.last
      @users_who_voted_for_ans_question = question_of_answer.users

      @all_answers_of_question = question_of_answer.answers 


      users_ids_arr = []

      @users_who_voted_for_ans_question.each do |user|
        users_ids_arr.push(user.id)
      end
      
      @user_voted_before = users_ids_arr.include?(current_user.id) 
      #true if user has voted for this question before    
  end
  end 

  ## POLL VOTE ##
  def poll_submit
    ans = Answer.find(params[:ans_id])
    current_user = User.find(params[:usr_id])
    question_of_answer = Question.find(ans.question.id)    
    id_initiative=params[:initiative_id]

    users_who_voted_for_ans_question = question_of_answer.users
    
    users_ids_arr = []

    users_who_voted_for_ans_question.each do |user|
      users_ids_arr.push(user.id)
    end
    
    user_voted_before = users_ids_arr.include?(current_user.id) 
    #true if user has voted for this question before
    
    if (user_voted_before == true) #user exists
      # "user exists for this question > not created"
  
     redirect_to({action: 'show', :id => id_initiative})      

     else
       ans.users << current_user
       question_of_answer.users << current_user
  
       redirect_to({action: 'show', :id => id_initiative})      
       # "Your data have been submited"      
    end

  end



end

private
def initiative_params
  params.require(:initiative).permit(:title, :description, :region_id, :user_id, :image, :tags, :sector_id)
end
