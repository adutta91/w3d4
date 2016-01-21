# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base

  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :not_author_of_poll

  belongs_to :respondent,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'

  belongs_to :answer_choice,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: 'AnswerChoice'

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll


  def sibling_responses
    self.question.responses
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: user_id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:user_id] << "Duplicate User ID!"
    end
  end

  def not_author_of_poll
    if self.question.poll.author_id == self.user_id
      errors[:user_id] << "Cheater!"
    end
  end

end
