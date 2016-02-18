require 'ruleby'

class InferenceEngine
  include Ruleby
	def initialize( rulebook, rules, facts )
		@rulebook = rulebook
		@rules = rules
		@facts = facts
	end

	def execute
		@ruleby_engine = engine :engine do |e|
	  		rulebook = @rulebook.constantize.new(e)
 	  		# rules applied
 	  		@rules.each do |rule|
				rulebook.add_rules( rule[0], rule[1], rule[2], rule[3] )			
 	  		end
 	  		
 	 		# facts applied
 	 		@facts.each do |fact|
 	 			e.assert fact
 	 		end
  	  		e.match
		end
	end

	def inference
		@ruleby_engine.facts.find  { |object| object.kind_of?( Inference ) }
	end
end