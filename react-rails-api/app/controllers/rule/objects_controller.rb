class Rule::ObjectsController < Rule::ApplicationController
	
	def index
		@objects = ObjectType.all
	end

	# GET /rules/1
	def show
		@object = get_object
	end


	def attributes
		@object_attributes = get_object_attr
	end

	private
	def get_object
		params.has_key?(:id) ? ObjectType.find(params[:id]) : nil
	end

	def get_object_attr
		params.has_key?(:id) ? ObjectAttribute.joins(:data_types).where( object_type_id: params[:id] ): nil
	end
end