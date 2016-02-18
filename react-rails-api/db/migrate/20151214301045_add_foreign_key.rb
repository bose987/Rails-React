class AddForeignKey < ActiveRecord::Migration
  def change
  	add_foreign_key :rules, :conclusion_types
  	add_foreign_key :rules, :users
  	add_foreign_key :expenses, 			:users
  	add_foreign_key :object_attributes, :data_types
  	add_foreign_key :object_attributes, :object_types
  	add_foreign_key :rule_items, 		:rules
  	add_foreign_key :user_notifications, :users
  end
end
