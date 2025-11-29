class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.all
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def submit
    @quiz = Quiz.find(params[:quiz_id])
    @submission = QuizSubmission.create!(user: current_user, quiz: @quiz, score: 0)

    @quiz.questions.each do |q|
      user_anser = params[:answers][q.id.to_s]
      correct = (user_anser == q.correct_answer)

      @submission.submission_answers.create!(
        question: q,
        user_anser: user_anser,
        correct: correct
      )
    end

    @submission.save
    redirect_to quiz_path(@quiz), notice: "Quiz Completed!"
  end
end
