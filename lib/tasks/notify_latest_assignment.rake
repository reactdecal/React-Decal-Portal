namespace :notify do
  desc "Sends email about latest assignment to all students"
  task :latest_assignment => :environment do
    a = Assignment.last
    emails = Semester.find_by(active: true).students.map {|s| s.email}
    emails += Admin.where(active: true).map {|a| a.email}
    emails.each do |e|
      StudentMailer.with(email: e, assignment: a).new_assignment.deliver
    end
  end

  desc "Sends testemail about latest assignment to all students"
  task :test_latest_assignment => :environment do
    a = Assignment.last
    StudentMailer.with(email: "staff+TEST@reactdecal.org", assignment: a).new_assignment.deliver
  end
end