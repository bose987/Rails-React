class RuleItem < ActiveRecord::Base
	belongs_to :rules
	belongs_to :object_types, :class_name => 'ObjectType', :foreign_key => "object_type_id"

end
