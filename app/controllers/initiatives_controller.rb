class InitiativesController < ApplicationController
  def index
  end

  def list
    @sectors = Sector.all

    if params[:searchTitle]
      @initiatives = Initiative.searchTitle(params[:searchTitle]).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
      @flag = "search_title"
      @flag_value = params[:searchTitle]

    elsif params[:region_name]
      @initiatives = Initiative.searchRegion(params[:region_name]).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
      @flag = "region"
      @flag_value = params[:region_name]
    elsif params[:friends_ids]
      @initiatives = []
      @users = current_user.followed_users
      @users.each do |user|
        initiatives = Initiative.where("user_id" => user.id)
        initiatives.each do |initiative|
          @initiatives.push(initiative)
        end
      end
      @initiatives = @initiatives.sort_by {|obj| obj.created_at}.reverse.paginate(:page => params[:page], :per_page => 5)
      @friend_initiative = true

    elsif params[:user_id]
      @initiatives = Initiative.where("user_id" => params[:user_id]).paginate(:page => params[:page], :per_page => 5)
      @flag = "search_user"
      @flag_value = User.find(params[:user_id])

    elsif params[:sector_name]
      @initiatives = Initiative.searchSector(params[:sector_name]).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
      @flag = "sector"
      @flag_value = params[:sector_name]

    elsif params[:tag]
      @initiatives = Initiative.tagged_with(params[:tag]).order('created_at DESC').paginate(:page => params[:page], :per_page => 5) 
      @flag = "tag"
      @flag_value = params[:tag]

    elsif params[:search_all]
      @initiatives = Initiative.searchAll(params[:search_all]).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
      @flag = "search_all"
      @flag_value = params[:search_all]
    else
      @initiatives = Initiative.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)

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
    @initiative.user_id = current_user.id.to_i
    
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
    @update_result = []
    @created_at_updates = []
    @initiative_results_updates = []
    @initiative = Initiative.find(params[:id])
   # @initiative.mina
    @updates = Update.where(initiative_id: params[:id]).order('created_at DESC')
    @count= @updates.length
    @comments = Comment.where("commentable_id" => params[:id]).where("commentable_type" => "initiative").order('created_at DESC')
    @results = @initiative.results

    @updates.each do |r|
      @initiative_results_updates.push(r)
      @created_at_updates.push(r.created_at)
    end

    @results.each do |r|
      @initiative_results_updates.push(r)

    end
    @update_result = @initiative_results_updates.sort_by {|obj| obj.created_at}.reverse


    
    #support initiative
    @supporters = @initiative.users.length
    @support_percent = ((@supporters)/0.1)
    
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


    ## SURVAY Existance & Answerd before TEST##
    @survay_exist = false
    @user_answered_before = false
    current_user_vs_survays_ids = []

    if @initiative.survays.last
      @survay_exist = true
    
      @survay = @initiative.survays.last

      @current_user = User.find(current_user.id)
      @current_user_feedbacks = @current_user.feedbacks
      for feedback in @current_user_feedbacks
        current_user_vs_survays_ids.push(feedback.survay_id) #array of all survay's ids answered for this user before
      end
      @user_answered_before  = current_user_vs_survays_ids.include?(@survay.id)

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

  def search_engine
    @result_initiatives_sector = []
    @sectors = Sector.all
    @regions = Region.all
    @search_type = params[:search_model]
    @sector_id = params[:sector_id]
    @region_id = params[:region_id]

    if params[:sector_id] == "كل الاقسام"
      @initiatives_sector = Initiative.all
    else
    @initiatives_sector = Initiative.where("sector_id" => params[:sector_id])  
    end
    if params[:region_id] == "كل الامارات"
      @initiatives_region = @initiatives_sector.all
    else
    @initiatives_region = @initiatives_sector.where("region_id" =>params[:region_id]) 
    end
    if params[:search_model] == "initiatives"
      @initiatives_title = @initiatives_region.searchTitle(params[:search_title]).paginate(:page => params[:page], :per_page => 5)
      @initiatives_number = @initiatives_region.searchTitle(params[:search_title]).length
    else

      @results = Result.searchResult(params[:search_title]).order('created_at DESC')         
  end
end

  def search
    @sectors = Sector.all
    @regions = Region.all
    
  end


end

private
def initiative_params
  params.require(:initiative).permit(:title, :description, :region_id, :user_id, :image, :tags, :sector_id)
end
