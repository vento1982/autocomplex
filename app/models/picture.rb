class Picture < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => {:medium => '300x300', :thumb => '100x100' }

  
  validates :name, presence: true
  validates :user, presence: true
  #add some more  validatons for uploading files
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /\Aimage\/(jpeg|png)\z/

end
