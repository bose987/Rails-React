class ManageSessionsController < DeviseTokenAuth::SessionsController

	def render_create_success
      auth_header = @resource.create_new_auth_token(@client_id)
      response.headers.merge!(auth_header)
      render json: {
        data: @resource.token_validation_response,
        access_token: auth_header
      }
    end
end
