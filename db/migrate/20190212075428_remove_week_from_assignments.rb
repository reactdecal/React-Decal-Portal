class RemoveWeekFromAssignments < ActiveRecord::Migration[5.1]
  def change
    remove_reference :assignments, :week, foreign_key: true
  end
end
