class PictureForm
	include Capybara::DSL

	def visit_page
		visit('/admin')
		click_on('Pictures')
		self
	end

	def add_picture(attr = {})
		click_on('New picture')
		fill_in('Name', with: attr.fetch(:name, 'good job'))
		attach_file('Image','spec/files/images/test.jpg')
		self
	end

	def submit
		click_on('Add picture')
		self
	end

end