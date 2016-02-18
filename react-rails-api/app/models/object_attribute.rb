class ObjectAttribute < ActiveRecord::Base
	belongs_to :object_types
	has_many :data_types, :foreign_key => "id"
end
