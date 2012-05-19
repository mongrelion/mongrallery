class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html

  def authorize!
    unless current_user.try :is_admin?
      flash[:warning] = 'Access restricted.'
      redirect_to root_path
    end
  end
end
