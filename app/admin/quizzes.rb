ActiveAdmin.register Quiz do
    permit_params :title, :description,
                                questions_attributes: [
                                    :id, :content, :question_type, :correct_answer, :_destroy,
                                    options_attributes: [:id, :text, :_destroy]
                                ]

    form do |f|
        f.inputs 'Quiz Details' do
            f.input :title
            f.input :description
        end
        f.inputs 'Questions' do
            f.has_many :questions, allow_destroy: true, new_record: 'Add Question' do |qf|
                qf.input :content
                qf.input :question_type, as: :select, collection: Question::QUESTION_TYPES
                qf.input :correct_answer

                qf.has_many :options, allow_destroy: true, new_record: 'Add Option' do |of|
                    of.input :text
                end
            end
        end

        f.actions
    end
end