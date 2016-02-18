class RuleInterpreter

	def self.generate_rule( item_rules )
		rules = ''
		
		item_rules.each do |item_rule|
			rule_condition 	= item_rule[0]
			object_name 	= item_rule[1]

			rule_gen = '['
			rule_gen << object_name + ','
			rule_gen << ':e,'
			rule_gen << rule_condition
			rule_gen << ']'

			rules << rule_gen
		end

		rules
	end
	
end