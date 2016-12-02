class AdminPage
	include Capybara::DSL

	def visit_page
		visit('/admin')
		self
	end

	def new_product
		click_on('New product')
		self
	end
end