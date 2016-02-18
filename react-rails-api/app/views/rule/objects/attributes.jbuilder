json.array! @object_attributes do |object_attribute|
 json.attributes object_attribute, :id, :name, :conditions
 json.data_type object_attribute.data_types, :name, :id
end