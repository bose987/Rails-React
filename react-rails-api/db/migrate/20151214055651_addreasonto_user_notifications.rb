class AddreasontoUserNotifications < ActiveRecord::Migration
  def change
  	add_column :user_notifications, :reason, :string, default:nil
  end
end
