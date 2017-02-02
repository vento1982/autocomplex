class Contact < MailForm::Base
	attribute :name, validate: true
	attribute :email, validate: true
	attribute :message, validate: true

	def headers
    {
      :subject => "My Contact Form",
      :to => "your.email@your.domain.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end