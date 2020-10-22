class Admin::AuthController < ApplicationController
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!, :site_selection

  helper_method :current_site

  layout 'admin'
 
  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  private

  def site_selection
    redirect_to new_admin_site_selection_path if current_site.blank?
  end

  def current_site
    begin
      @current_site ||= unless current_site_id.blank?
        Site.find(current_site_id)
      else
        nil
      end
    rescue
      nil
    end
  end

  def current_site_id
    session[:site_id] || nil
  end
end
