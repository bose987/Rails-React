class RuleController < ApplicationController
	before_action :set_rule
	before_action :authenticate_user!
    authorize_resource :class => RuleController

	def create
		@rule = Rule.new(rule_params)
		if @rule.save
			render json: @rule, status: :created
		else
			render json: @rule.errors, status: :unprocessable_entity
		end
	end

	# GET /rules/1
	def show
		@rule
	end


	private
	def set_rule
		@rule = params.has_key?(:id) ? Rule.joins(:rule_items, :object_types).find(params[:id]) : nil
	end

	def rule_params
		params[:rule]
	end
end