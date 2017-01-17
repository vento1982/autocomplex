class Product < ActiveRecord::Base
	validates :title, presence: true
	validates :title, uniqueness: true
	validates :description, presence: true

	belongs_to :user
end
