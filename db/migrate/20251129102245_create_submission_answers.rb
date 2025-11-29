class CreateSubmissionAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :submission_answers do |t|
      t.references :quiz_submission, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :user_anser
      t.boolean :correct

      t.timestamps
    end
  end
end
