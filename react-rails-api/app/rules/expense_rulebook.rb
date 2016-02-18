require 'ruleby'
class ExpenseRulebook < Ruleby::Rulebook

	def initialize(obj_engine)
		super(obj_engine)
		@inference = Inference.new
	end

	def add_rules( rule_name, rules_id, conclusion_id, rule_condition )
		rule rule_name.to_sym,
			eval( rule_condition  ) do |v|
				assert @inference
				assert @inference.rules_passed( rules_id, conclusion_id )
		end
	end
end

class Inference
	  def initialize
	  	@conclusions = []
	  end

	  def rules_passed( rule_id, conclusion_id )
	  	@conclusions << {rule_id: rule_id, conclusion_type_id: conclusion_id}
	  end

	  def get_conclusions
		@conclusions
	  end

end

