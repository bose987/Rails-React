json.rule @rule, :id, :name, :description, :result
json.rule_items @rule.rule_items, :id, :condition, :object_type_id
json.object_types @rule.object_types, :id, :name, :description