ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 465,
    :domain               => "letmepractice.com",
    :user_name            => "LetMePractice",
    :password             => "hirennikunj",
    :authentication       => "plain",
    :enable_starttls_auto => true,
    :content_type => "text/html"
}

ActionMailer::Base.default_url_options[:host] = "localhost"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?