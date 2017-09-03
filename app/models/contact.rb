class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message

  # Declare e-mail headers. Accepts same as mail method in ActionMailer.
  def headers
    {
        :subject => "My Contact Form",
        :to => ENV['GMAIL_USERNAME'],
        :from => %("#{name}" <#{email}>)
    }
  end
end
