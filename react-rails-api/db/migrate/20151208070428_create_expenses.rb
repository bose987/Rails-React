class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
	  t.belongs_to :user, index:true
	  t.string 	:name, null: false
	  t.integer	:expense_type_id
    t.integer :amount
	  t.string	:description 
    t.timestamps null: false
    end
  end
end
