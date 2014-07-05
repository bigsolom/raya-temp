class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  def index
    @polls = Poll.all
  end

  
  def show
    @poll = Poll.find(params[:id])
  end

  
  def new
    @initiative = Initiative.find(params[:initiative_id])
    @poll = Poll.new
     1.times do 
       question = @poll.questions.build
       2.times{question.answers.build}
     end
    @initiative_id = params[:initiative_id]


  end

  
  def edit
  end

  def create

    @poll = Poll.new(poll_params)
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:name, :initiative_id,
      :questions_attributes => [:id, :content,
        :answers_attributes => [:id, :content]
      ])
    end
end
