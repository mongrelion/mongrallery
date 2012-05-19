class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html
  helper_method :current_admin?

  def current_admin?
    current_user.try :is_admin?
  end

  def authorize!
    unless current_admin?
      redirect_to root_path, alert: 'Access restricted.'
    end
  end
end
