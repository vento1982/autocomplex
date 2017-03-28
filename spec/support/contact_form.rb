class ContactForm
	include Capybara::DSL

	def visit_page
		visit '/contacts'
		self
	end

	def add_msg(attr={})
		fill_in 'Name', with: attr.fetch(:name, 'New name')
		fill_in 'Email', with: attr.fetch(:email, 'Your email')
		fill_in 'Message', with: attr.fetch(:message, 'Msg')
		self
	end

	def submit
		click_on 'Submit your message'
		self
	end

end