class AddDymepieces < ActiveRecord::Migration
  def change
  	 create_table :dymepieces do |t|
		  t.string :topic
		  t.references :user
		  t.timestamps
		end
  end
end
