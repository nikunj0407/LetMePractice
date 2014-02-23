class UserMailer < ActionMailer::Base
  default from: "mail@letmepractice.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")

    puts 'mail sent to ' + user.name
  end
end
