class Rule < ActiveRecord::Base
	has_many :rule_items
	has_many :rule_conclusions
	has_many :object_types, :through => :rule_items
end
