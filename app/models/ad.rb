class Ad < ActiveRecord::Base
	validates :title, presence: true
	validates :description, presence: true
	validates :validity, presence: true

	belongs_to :user
end
