class AddReasonToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :reason, :string, default:nil
  end
end
