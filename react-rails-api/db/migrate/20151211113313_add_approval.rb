class AddApproval < ActiveRecord::Migration
  def change
  	add_column :user_notifications, :approval_status_type_id, :integer, default:0
  end
end
