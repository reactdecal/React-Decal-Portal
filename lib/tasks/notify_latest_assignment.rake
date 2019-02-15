namespace :notify do
  desc "Sends email about latest assignment to all students"
  task :latest_assignment => :environment do
    a = Assignment.last
    emails = Semester.find_by(active: true).students.map {|s| s.email}
    StudentMailer.with(emails: emails, assignment: a).new_assignment.deliver
  end

  desc "Sends testemail about latest assignment to all students"
  task :test_latest_assignment => :environment do
    a = Assignment.last
    StudentMailer.with(emails: ["staff+TEST@reactdecal.org"], assignment: a).new_assignment.deliver
  end
end