class PollsController < ApplicationController
  before_action :find_poll, only: [ :show, :edit, :update, :destroy ]

  def index
    @polls = Poll.all.order("created_at DESC")
  end

  def new
    @poll = Poll.new
  end

  def create

    @poll = Poll.create(poll_params)

    if @poll.save
      flash[:notice] = "Poll saved successfully"
      redirect_to polls_path
    else
      flash[:notice] = "Could not be saved"
      render "new"
    end

  end

  def show
    @questions = @poll.questions
  end

  def edit

  end

  def update

    if @poll.update(poll_params)
      flash[:notice] = "Poll updated successfully"
      redirect_to polls_path
    else
      flash[:notice] = "Could not be updated"
      render "edit"
    end

  end

  def destroy
    @poll.delete
    flash[:notice] = "Poll deleted successfully"
    redirect_to polls_path
  end

  private

    def poll_params
      params.require(:poll).permit(:title)
    end

    def find_poll
      @poll = Poll.find(params[:id])
    end
end
