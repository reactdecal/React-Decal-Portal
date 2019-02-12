class AssignmentsController < ApplicationController
	before_action :authenticate!

	def index
		@semester = Semester.find(params[:semester_id])
		@assignments = @semester.assignments
	end

	def create
		assignment = Assignment.new (assignment_params)
		assignment.semester = Semester.find_by(active: true)
		if assignment.save!
			flash[:notice] = "New assignment created!"
			redirect_to semester_assignments_path semester_id: assignment.semester_id
		else
			puts assignment.errors.full_messages.to_sentence
			flash[:error] = assignment.errors.full_messages.to_sentence
			redirect_to '/'
		end
	end

	def update
		assignment = Assignment.find(params[:id])
		assignment.update! assignment_params
		semester = Semester.find_by active: true
		flash[:notice] = "Changes saved"
		redirect_to semester_assignments_path semester_id: semester.id
	end

	def destroy
		Assignment.find(params[:id]).destroy
		flash[:alert] = "Assignment deleted"
		redirect_to semester_assignments_path semester_id: params[:semester_id]
	end

	private
	def assignment_params
		params.require(:assignment).permit(:link, :submission_link, :title, :due_date, :points, :description, :semester_id)
	end
end
