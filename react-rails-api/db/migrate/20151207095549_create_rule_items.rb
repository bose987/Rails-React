class CreateRuleItems < ActiveRecord::Migration
  def change
    create_table :rule_items do |t|
	  t.belongs_to :rule, index:true
	  t.string :condition, null: false
      t.timestamps null: false
    end
  end
end
