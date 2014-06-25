class AddItems < ActiveRecord::Migration
  def change
  	create_table :items do |t|
		  t.string :img_url
		  t.string :description
		  t.references :dymepiece
		  t.references :user
		end
  end
end
