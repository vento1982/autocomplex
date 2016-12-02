class LoginForm
	include Capybara::DSL

	def visit_page
		visit('/admin/sign_in')
		self
	end

	def login_as(user)
		fill_in('Email', with: user.email)
		fill_in('Password', with: user.password)
		click_on('Log in')
		self
	end
end