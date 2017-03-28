module Admin::BaseHelper

	def quantity_grater_then_ten(index) 
		params[:page].to_i > 1 ? (params[:page].to_i * 10) + index + 1 : index + 1
	end
	
end
