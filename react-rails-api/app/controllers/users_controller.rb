class UsersController < ApplicationController
  include CanCan::ControllerAdditions
  #before_filter :check_permissions, :only => [:create, :members_only]
  before_action :authenticate_user!
  authorize_resource :class => UsersController

=begin
  def check_permissions
  	authorize! :create, :members_only
  end
=end


  def members_only
    render json: {
      data: {
        message: "Welcome #{current_user.email}",
        user: current_user
      }
    }, status: 200
  end
  def create
  	###
  end

  def my_profile
    render json: {
      data: {
        user: current_user
      }
    }
  end
end