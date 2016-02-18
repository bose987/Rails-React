class NotificationsController < ApplicationController
	before_action :authenticate_user!
  authorize_resource :class => NotificationsController

	def index
    @notifications = UserNotification.joins("INNER JOIN expenses ON expenses.id = user_notifications.ref_id").select('expenses.*,user_notifications.*').all
	end

  def approve_expense
    @notification = UserNotification.find(params[:id])
    @notification.update(approval_status_type_id: 1, reason: params[:reason] )
  end

  def reject_approval
    @notification = UserNotification.find(params[:id])
    @notification.update(approval_status_type_id: 2, reason: params[:reason] )
  end
end
