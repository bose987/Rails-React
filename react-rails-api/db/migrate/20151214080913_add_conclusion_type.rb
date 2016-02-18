class AddConclusionType < ActiveRecord::Migration
  def change
  	add_column :rules, :conclusion_type_id, :integer
  end
end
