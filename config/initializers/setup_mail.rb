ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "letmepractice.com",
    :user_name            => "LetMePractice",
    :password             => "hirennikunj",
    :authentication       => "plain",
    :enable_starttls_auto => true,
    :content_type => "text/html"
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?