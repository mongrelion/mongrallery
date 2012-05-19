class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html
  helper_method :current_admin?

  def current_admin?
    current_user.try :is_admin?
  end

  def authorize!
    unless current_admin?
      flash[:warning] = 'Access restricted.'
      redirect_to root_path
    end
  end
end
