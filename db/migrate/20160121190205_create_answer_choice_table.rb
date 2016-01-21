class CreateAnswerChoiceTable < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.integer :question_id, null: false
      t.string :text

      t.timestamps
    end
  end
end
