class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
     t.belongs_to :user, index:true
	   t.integer	:notification_type_id
	   t.integer	:ref_id
	   t.integer	:rule_id
	   t.string	:description 
     t.timestamps null: false
    end
  end
end
