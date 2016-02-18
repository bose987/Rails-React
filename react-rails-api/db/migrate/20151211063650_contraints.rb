class Contraints < ActiveRecord::Migration
  def change
  	#add_index :data_types, [:name], :unique => true, :name => 'dt_table_constraints'
  	#add_index :object_types, [:name], :unique => true, :name => 'ot_table_constraints'
  	#add_index :object_attributes, [:object_type_id, :data_type_id, :name], :unique => true, :name => 'oa_table_constraints'
  	#add_index :user_notifications, [:user_id, :ref_id, :notification_type_id, :rule_id], :unique => true, :name => 'un_table_constraints'
  end
end
