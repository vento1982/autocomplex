class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.datetime :validity

      t.timestamps null: false
    end
  end
end
