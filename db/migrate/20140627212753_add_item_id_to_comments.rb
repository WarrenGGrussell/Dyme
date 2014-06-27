class AddItemIdToComments < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
  		t.references :item
  	end
  end
end
