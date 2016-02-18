require 'ruleby'
class ExpensesController < ApplicationController
  
  def index
	@expense_type = []
  	@expense_type << { id: 1, name: 'Rent' }
  	@expense_type << { id: 2, name: 'Utilities' }
  	@expense_type << { id: 3, name: 'Insurance' }
  	@expense_type << { id: 4, name: 'Fees'}
  	@expense_type << { id: 5, name: 'Wages'}
  	@expense_type << { id: 6, name: 'Taxes'}
  	@expense_type << { id: 7, name: 'Interest'}
  	@expense_type << { id: 8, name: 'Supplies'}
  	@expense_type << { id: 9, name: 'Depreciation'}
  	@expense_type << { id: 10, name: 'Maintenance'}
  	@expense_type << { id: 11, name: 'Meals and Entertainment'}
  	@expense_type << { id: 12, name: 'Training'}

  end
  
  def create
	@expense = Expense.new(permitted_params)
	@expense.save

	expense_rules

  end
  
  protected
    def permitted_params
      params.permit(
          expense: [
              :name,
			  :expense_type_id,
              :amount,
			  :description
		  ]
      )[:expense]
    end

    def notify_manager
		@notification = UserNotification.new
    	@notification.description = "Needs Approval Expense Amount: #{@expense.amount}" 
    	@notification.notification_type_id = 1
    	@notification.user_id = 2
		@notification.rule_id = @inference.get_rules[0]
		@notification.ref_id = @expense.id
		@notification.save
    end

    def expense_rules
		@rules = []
		obj_rules = Rule.joins(:rule_items, :object_types).all
    	
		obj_rules.each do |rule|
			item_rules = []
			rule.rule_items.each do |rule_items|
				rule_conditions = []
				rule_conditions << rule_items.condition
				rule_conditions << rule_items.object_types.name
	
				item_rules << rule_conditions
			end
			@rules << [rule.name,  RuleInterpreter.generate_rule( item_rules ), rule.id]
		end

		# facts on which to apply
		facts = [ 
			@expense
		]
		inference_engine = InferenceEngine.new( 'ExpenseRulebook', @rules, facts ) 
		inference_engine.execute
		@inference = inference_engine.inference

		notify_manager if @inference && @inference.get_rules[0] > 2

    end

end