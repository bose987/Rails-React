class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
	  t.string :name, null: false
	  t.string :description
	  t.string :result, null: false
      t.timestamps null: false
    end
  end
end
