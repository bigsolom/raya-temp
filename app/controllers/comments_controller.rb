class CommentsController < ApplicationController
  def create
  	@comment = Comment.new
    @comment.content = params[:content]
    @comment.commentable_id = 1
    @comment.commentable_type = "initiative"
    if @comment.save
    	redirect_to :controller => "initiatives", :action => "show", :id =>1
    else 
    	redirect_to :controller => "initiatives", :action => "show"
  end
end
end
