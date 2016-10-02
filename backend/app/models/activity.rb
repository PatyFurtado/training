class Activity < ActiveRecord::Base
  validates :question, presence: true, length: { minimum:3 }
  validates :correct_answer, presence: true, length: { minimum:3 }
  validates :incorrect_answer_1, presence: true, length: { minimum:3 }
  validates :incorrect_answer_2, presence: true, length: { minimum:3 }
  validates :incorrect_answer_3, presence: true, length: { minimum:3 }
  validates :incorrect_answer_4, presence: true, length: { minimum:3 }
  belongs_to :modulo
  has_many :answers
  has_many :users, through: :answers

  def builder_question(current_user)
    @activity_student = self.answers.where(user_id: current_user.id).first
    Jbuilder.new do |activity_match_student|
      activity_match_student.question self.question
      activity_match_student.answer_a get_answer_match(@activity_student.answer_a)
      activity_match_student.answer_b get_answer_match(@activity_student.answer_b)
      activity_match_student.answer_c get_answer_match(@activity_student.answer_c)
      activity_match_student.answer_d get_answer_match(@activity_student.answer_d)
      activity_match_student.answer_e get_answer_match(@activity_student.answer_e)
      activity_match_student.answer_student get_answer_student_match(@activity_student)
    end
  end

  def get_id_answer(current_user, student_answer)
    @activity_student = self.answers.where(user_id: current_user.id).first
    return @activity_student.answer_a if student_answer === 'answer_a'
    return @activity_student.answer_b if student_answer === 'answer_b'
    return @activity_student.answer_c if student_answer === 'answer_c'
    return @activity_student.answer_d if student_answer === 'answer_d'
    return @activity_student.answer_e if student_answer === 'answer_e'
  end

  private

  def get_answer_match(id)
    return self.correct_answer if id == 0
    return self.incorrect_answer_1 if id == 1
    return self.incorrect_answer_2 if id == 2
    return self.incorrect_answer_3 if id == 3
    return self.incorrect_answer_4 if id == 4
  end
  def get_answer_student_match(activity_student)
    return 'answer_a' if activity_student.answer_a === activity_student.answer_student
    return 'answer_b' if activity_student.answer_b === activity_student.answer_student
    return 'answer_c' if activity_student.answer_c === activity_student.answer_student
    return 'answer_d' if activity_student.answer_d === activity_student.answer_student
    return 'answer_e' if activity_student.answer_e === activity_student.answer_student
  end
end
