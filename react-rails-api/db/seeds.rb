=begin
ConclusionType.create!([
  {id: 1, name: "TL", description: nil},
  {id: 2, name: "Manager", description: nil}
])

DataType.create!([
  {id: 1, name: "Integer", description: "Integer"},
  {id: 2, name: "String", description: "String"},
  {id: 3, name: "Timestamp", description: "Timestamp"}
])
ObjectType.create!([
  {id: 2, description: "User class", name: "User"},
  {id: 3, description: "Invoice class", name: "Invoice"},
  {id: 1, description: "Expense class", name: "Expense"}
])

Rule.create!([
  {id: 1, name: "Rule2", description: "1000 < i < 2000 ", user_id: 1, conclusion_type_id: 2},
  {id: 2, name: "Rule1", description: "i < 1000", user_id: 1, conclusion_type_id: 2},
  {id: 3, name: "Rule3", description: "2000 < i < 5000", user_id: 1, conclusion_type_id: 2},
  {id: 4, name: "Rule4", description: "5000 < i < 10000", user_id: 1, conclusion_type_id: 2},
  {id: 5, name: "Rule5", description: "i > 20000", user_id: 1, conclusion_type_id: 2}
])
=end

ObjectAttribute.create!([
  {id: 1, object_type_id: 1, data_type_id: 1, name: "user_id", description: "user_id", conditions: ["=="]},
  {id: 2, object_type_id: 1, data_type_id: 1, name: "amount", description: "Amount", conditions: ["<", ">", "==", "<=", ">=", "!="]},
  {id: 3, object_type_id: 1, data_type_id: 1, name: "expense_type_id", description: "expense_type_id", conditions: ["==", "!="]},
  {id: 4, object_type_id: 1, data_type_id: 3, name: "created_at", description: "created_at", conditions: ["<", ">", "==", "<=", ">=", "!="]},
  {id: 5, object_type_id: 2, data_type_id: 2, name: "email", description: "email", conditions: ["=="]},
  {id: 6, object_type_id: 2, data_type_id: 3, name: "created_at", description: "created_at", conditions: ["<", ">", "==", "<=", ">=", "!="]}
])

RuleItem.create!([
  {id: 3, rule_id: 3, condition: "m.amount > 2000, m.amount <= 5000", object_type_id: 1},
  {id: 5, rule_id: 5, condition: "m.amount > 10000", object_type_id: 1},
  {id: 4, rule_id: 4, condition: "m.amount > 5000, m.amount <= 10000", object_type_id: 1},
  {id: 2, rule_id: 2, condition: "m.amount > 1000, m.amount <= 2000", object_type_id: 1},
  {id: 1, rule_id: 1, condition: "m.amount <= 1000", object_type_id: 1}
])
