class User < ActiveRecord::Base
	has_many :dymepieces
	has_many :comments
	has_many :items
	validates :username, :email, :password, uniqueness: true
	validates :email, :email => true
end