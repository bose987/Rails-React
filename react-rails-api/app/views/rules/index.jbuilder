arr_rule_ids = []
json.array! @rules do |rule|
	
  next if arr_rule_ids.include?(rule.id)
	
  arr_rule_ids << rule.id 

  json.rule rule, :id, :name, :description, :conclusion_type_id
  json.rule_items rule.rule_items, :id, :condition, :object_type_id
  json.object_types rule.object_types, :id, :name
  end