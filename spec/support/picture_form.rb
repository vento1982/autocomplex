class PictureForm
	include Capybara::DSL

	def visit_page
		visit('/admin')
		click_on('Pictures')
		self
	end

	def add_picture(params = {})
		click_on('New picture')
		fill_in('Name', with: params.fetch(:name, 'good job'))
		attach_file('Image',"#{Rails.root}/spec/files/images/" + params.fetch(:image, 'test.jpg'))
		self
	end

	def submit
		click_on('Add picture')
		self
	end

end