class RemoveResults < ActiveRecord::Migration
  def change
  	remove_column :rules, :result
 	add_column :rules, :user_id, :integer
  end
end
