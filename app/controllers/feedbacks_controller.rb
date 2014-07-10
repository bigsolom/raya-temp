class FeedbacksController < ApplicationController
  def new
  	@feedback = Feedback.new()
  end

  def create
  	@user_answered_id = params[:user_id]
  	@initiative_id = params[:initiative_id]

  	@feedback = Feedback.new(feedback_params)
  	@user_answered = User.find(@user_answered_id)
  	if @feedback.save
		@feedback.users << @user_answered
			redirect_to(:controller => 'initiatives',:action => 'show', :id => @initiative_id )
	else 
      render('list')
    end 
  end


  private
  def feedback_params
  	params.require(:feedback).permit(:answer, :survay_id)
  end
end
