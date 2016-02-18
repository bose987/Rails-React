class Expense < ActiveRecord::Base
	belongs_to :users
	has_many :user_notifications
end
