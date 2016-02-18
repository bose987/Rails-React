class RuleItems < ActiveRecord::Migration
  def change
  	add_column :rule_items, :object_type_id, :integer
  end
end
