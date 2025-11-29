
ActiveAdmin.register QuizSubmission do
	# Allow basic assignment if creating/editing from admin
	permit_params :quiz_id, :user_id,
								submission_answers_attributes: [:id, :question_id, :user_anser, :correct, :_destroy]

	filter :quiz, collection: proc { Quiz.all.pluck(:title, :id) }
	filter :user, collection: proc { User.all.pluck(:email, :id) }
	filter :created_at

	index do
		selectable_column
		id_column
		column :quiz do |s|
			link_to s.quiz.title, admin_quiz_path(s.quiz) if s.quiz
		end
		column :user do |s|
			s.user&.email
		end
		column 'Score' do |s|
			total = s.submission_answers.size
			correct = s.submission_answers.select { |a| a.correct }.size
			if total > 0
				pct = ((correct.to_f / total) * 100).round
				"#{correct}/#{total} (#{pct}%)"
			else
				'N/A'
			end
		end
		column :created_at
		actions
	end

	show do
		attributes_table do
			row :id
			row :quiz do |s|
				link_to s.quiz.title, admin_quiz_path(s.quiz) if s.quiz
			end
			row :user do |s|
				s.user&.email
			end
			row :created_at
			row :updated_at
		end

		panel 'Submission Answers' do
			table_for quiz_submission.submission_answers.includes(:question) do
				column 'Question' do |ans|
					ans.question&.content
				end
				column 'Your Answer', &:user_anser
				column 'Correct' do |ans|
					status_tag(ans.correct ? 'Yes' : 'No', class: (ans.correct ? 'ok' : 'warning'))
				end
				column 'Correct Answer' do |ans|
					ans.question&.respond_to?(:correct_answer) ? ans.question.correct_answer : ''
				end
			end
		end
	end
end
