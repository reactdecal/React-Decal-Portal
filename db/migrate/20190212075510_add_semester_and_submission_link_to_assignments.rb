class AddSemesterAndSubmissionLinkToAssignments < ActiveRecord::Migration[5.1]
  def change
    add_reference :assignments, :semester, foreign_key: true
    add_column :assignments, :submission_link, :string
  end
end
