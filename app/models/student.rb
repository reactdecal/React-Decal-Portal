# == Schema Information
#
# Table name: students
#
#  id          :integer          not null, primary key
#  name        :string
#  email       :string
#  picture     :string
#  semester_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :rememberable, :trackable, :validatable, :confirmable
  belongs_to :semester, optional: true
  validates :name, presence: true
  validate :valid_enrollment, :on => :create
  has_many :attendances
  has_many :student_submissions
  has_many :submissions, :through => :student_submissions

  def valid_enrollment
    semester = Semester.latest
    if semester.nil?
      errors.add(:base, "There are no available semesters")
    end
  end

  after_create -> { add_semester(Student.last) }

  private

  def add_semester(student)
    semester = Semester.latest
  	student.update semester: semester
    semester.weeks.each {|week| Attendance.create status: :absent, week: week, student: student }
  end
end
