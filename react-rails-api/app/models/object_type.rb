class ObjectType < ActiveRecord::Base
	has_many :rule_items
	has_many :object_attributes
end
