require 'ruleby'
class ExpensesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource :class => ExpensesController

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
    @expense.user_id = current_user.id
  	@expense.save
  	expense_rules
  end

  def view_expenses
    @expenses = Expense.joins("LEFT JOIN user_notifications ON user_notifications.ref_id = expenses.id").select('expenses.*,user_notifications.approval_status_type_id,user_notifications.reason').all
  end

  def view_user_expenses
    @expenses = Expense.joins("LEFT JOIN user_notifications ON user_notifications.ref_id = expenses.id").select('expenses.*','user_notifications.approval_status_type_id,user_notifications.reason').where( "expenses.user_id = ?", current_user.id )
  end
  
  protected
    def permitted_params
      params.permit([
	      	:name,
	        :expense_type_id,
	        :amount,
	        :description
		]
      )
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
  			@rules << [rule.name, rule.id, rule.conclusion_type_id , rule_condition = RuleInterpreter.generate_rule( item_rules )]
		  end

  		inference_engine = InferenceEngine.new( 'ExpenseRulebook', @rules, facts = [@expense] ) 
  		inference_engine.execute
  		@inference = inference_engine.inference
      
		  notify_manager if @inference.get_conclusions[0][:conclusion_type_id] >= 2
    end

    def notify_manager
		  @notification = UserNotification.new
    	@notification.description = "Needs Approval Expense Amount: #{@expense.amount}" 
    	@notification.notification_type_id = 1
    	@notification.user_id = current_user.user_id
		  @notification.rule_id = @inference.get_conclusions[0][:rule_id]
		  @notification.ref_id = @expense.id
		  @notification.save
    end
end