class Job < ActiveRecord::Base
  validates :name, presence: { message: "must be given please" }
  validates :email, presence: true
  validates :message, presence: true
  validates :ad, presence: true

  belongs_to :ad
end
