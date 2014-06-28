class CommentsController < ApplicationController
  def create
  	@comment = Comment.new
    @comment.content = params[:content]
    @comment.commentable_id = params[:initiative_id]
    @comment.commentable_type = "initiative"
    @comment.user_id = current_user.id
    if @comment.save
    	redirect_to :controller => "initiatives", :action => "show", :id =>params[:initiative_id]
    else 
    	redirect_to :controller => "initiatives", :action => "show"
  end
end
end
