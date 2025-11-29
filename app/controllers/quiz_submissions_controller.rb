class QuizSubmissionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @submissions = current_user.quiz_submissions.includes(:quiz)
  end

  def show
    @submission = current_user.quiz_submissions.find(params[:id])
  end
end
