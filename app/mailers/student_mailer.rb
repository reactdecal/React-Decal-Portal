class StudentMailer < ApplicationMailer
    default from: 'staff@reactdecal.org'

    def new_assignment
        @assignment = params[:assignment]
        @email = params[:email]
        mail(to: @email, subject: 'React Decal Assignment Posted!')
    end
end
