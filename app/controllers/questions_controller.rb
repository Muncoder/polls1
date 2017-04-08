class QuestionsController < ApplicationController

  before_action :find_question, only: [ :show, :edit, :update, :destroy ]
  before_action :set_poll
  before_action :set_kind_options, only: [ :new, :create, :edit, :update ]

  def index
    @polls = Question.all.order("created_at DESC")
  end

  def new
    @question = @poll.questions.build
    5.times { @question.possible_answers.build }
  end

  def create

    @question = @poll.questions.create(question_params)

    if @question.save
      flash[:notice] = "Question saved successfully"
      redirect_to @question.poll
    else
      flash[:notice] = "Could not be saved"
      render "new"
    end

  end

  def show
  end

  def edit

  end

  def update

    if @question.update(question_params)
      flash[:notice] = "Question updated successfully"
      redirect_to questions_path
    else
      flash[:notice] = "Could not be updated"
      render "edit"
    end

  end

  def destroy
    @question.delete
    flash[:notice] = "Question deleted successfully"
    redirect_to questions_path
  end

  private

    def question_params
      params.require(:question).permit(:title, :kind, :poll_id, { possible_answers_attributes: [ :title, :question_id ] })
    end

    def find_question
      @question = Question.find(params[:id])

    end

    def set_poll
    	@poll = Poll.find(params[:poll_id])
    end

    def set_kind_options
		@kind_options = [ ["Open answer", "open"], [ "Choice", "choice" ] ]
    end

end
