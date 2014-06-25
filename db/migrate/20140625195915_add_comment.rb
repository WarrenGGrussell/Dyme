class AddComment < ActiveRecord::Migration
  def change
  	 create_table :comments do |t|
		  t.string :content
		  t.references :user
		  t.references :dymepiece
		  t.timestamps
		end
  end
end
