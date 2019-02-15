class StudentMailer < ApplicationMailer
    default from: 'staff@reactdecal.org'

    def new_assignment
        @assignment = params[:assignment]
        @emails = params[:emails]
        mail(cc: "staff@reactdecal.org", bcc: @emails, subject: 'React Decal Assignment Posted!')
    end
end
