class Item < ActiveRecord::Base
	belongs_to :user
	belongs_to :dymepiece
	has_many :comments, dependent: :destroy
end