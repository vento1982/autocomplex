class ProductForm 
	include Capybara::DSL

	def add_product(attr = {})
		fill_in('Title', with: attr.fetch(:title, 'good job'))
		fill_in('Description', with: attr.fetch(:description, 'nice descritption'))
		self
	end

	def submit
		click_on('Add product')
		self
	end
end