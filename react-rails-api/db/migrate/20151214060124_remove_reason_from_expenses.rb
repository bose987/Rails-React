class RemoveReasonFromExpenses < ActiveRecord::Migration
  def change
    remove_column :expenses, :reason, :string
    remove_column :expenses, :status, :integer
  end
end
