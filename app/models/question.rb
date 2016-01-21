# == Schema Information
#
# Table name: questions
#  id            :integer          not null, primary key
#  question_text :string           not null
#  poll_id       :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Question < ActiveRecord::Base

  validates :poll_id, presence: true

  belongs_to :poll,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: 'Poll'

  has_many :answer_choices,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: 'AnswerChoice'

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    result_hash = {}
    # questions = Question.includes(answer_choices: :responses)
    # questions_array = questions.joins(:responses).select("responses.*")
    #

    # answers = Question.includes(:answer_choices)

    #here's the n+1 code
    # self.answer_choices.each do |ac|
    #   result_hash[ac.text] = ac.responses.count
    # end
    self.answer_choices.includes(:responses).each do |ac|
      result_hash[ac.text] = ac.responses.length
    end
    result_hash


  end


end
