class ApplicationController < ActionController::Base
   # Prevent CSRF attacks by raising an exception.
   # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def require_admin
    redirect_to '/' unless current_user.admin?
  end

  def check_user_status
    redirect_to '/' unless current_user.status>0
  end

  def after_sign_in_path_for(resource)
    # request.env['omniauth.origin'] || stored_location_for(resource) || recordings_path
    recordings_path
  end

  def after_sign_out_path_for(resource_or_scope)
    # request.referrer
    recordings_path
  end

  private

  def record_not_found
    render :url => "public/404.html", :status => 404
  end

end
