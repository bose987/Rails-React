class AddStatusToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :status, :integer, default: 0
  end
end
