class ApplicationController < ActionController::Base
	include DeviseTokenAuth::Concerns::SetUserByToken
	before_action :authenticate_user_from_token!
    before_action :authenticate_user!

 	before_action :cors_set_access_control_headers

  def cors_set_access_control_headers
	headers['Access-Control-Allow-Origin'] = request.headers.include?('Origin') ? request.headers['Origin'] : '*'

	headers['Access-Control-Expose-Headers'] = 'ETag'
	headers['Access-Control-Request-Method'] = '*'
	headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
	headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, accept, access-token, client, content-type, uid'
	headers['Access-Control-Max-Age'] = '1728000'
	headers['Access-Control-Allow-Credentials'] = 'true'

  end

  	rescue_from CanCan::AccessDenied do |exception|
       	render json: {
       		error: "Not having permission to access"
    	}
    end

    def preflight
    	headers['Access-Control-Request-Method'] = '*'
      	render :text => 'options', :content_type => 'text/plain'
	end
	
	protected
	  def authenticate_user_from_token!
		user_token = if params[:authenticity_token].presence
					   params[:authenticity_token].presence
					 elsif params[:private_token].presence
					   params[:private_token].presence
					 end
		user = user_token && User.find_by_authentication_token(user_token.to_s)
	  end
	  
      def authenticate_user!(*args)
	  end
	  
	  
	  def render_403
		head :forbidden
	  end
	  
	  def render_404
	  end
	  
	  def access_denied!
      end
=begin
	  def default_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Expose-Headers'] = 'ETag'
		headers['Access-Control-Request-Method'] = '*'
		headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
		headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, accept, access-token, client, content-type, uid'
		headers['Access-Control-Max-Age'] = '1728000'
	  end
=end

end
