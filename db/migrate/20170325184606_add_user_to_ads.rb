class AddUserToAds < ActiveRecord::Migration
  def change
    add_reference :ads, :user, index: true, foreign_key: true
  end
end
