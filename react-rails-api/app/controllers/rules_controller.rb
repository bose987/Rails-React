class RulesController < ApplicationController
	#before_action :authenticate_user!
    #authorize_resource :class => RulesController
	def index
		@rules = Rule.joins(:rule_items, :object_types).all
	end

	def info

	end
end
