class PicturePage
	include Capybara::DSL

	def visit_page
		visit('/admin/pictures')
		click_link('show-picture')
		self
	end
end