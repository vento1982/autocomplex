class AdForm
	include Capybara::DSL

	def visit_page
		visit('/admin')
		click_on('Ads')
		self
	end

	def add_ad(attr = {})
		click_on('Add ad')
		fill_in('Title', with: attr.fetch(:title, 'Your Job!'))
		fill_in('Description', with: attr.fetch(:description, 'Desc job!'))
		select '2017', from: 'ad[validity(1i)]' 
		select 'March', from: 'ad[validity(2i)]'
		select '20', from: 'ad[validity(3i)]'
		select '18', from: 'ad[validity(4i)]'
		select '00', from: 'ad[validity(5i)]'
		self
	end

	def submit
		click_on('Add ad')
		self
	end
end