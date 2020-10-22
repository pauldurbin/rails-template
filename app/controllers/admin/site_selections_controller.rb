class Admin::SiteSelectionsController < ApplicationController
  before_action :authenticate_user!

  layout 'devise'

  def new
    render action: :new, locals: { sites: sites }
  end

  def create
    unless site_id.blank?
      session[:site_id] = permitted_params.fetch(:site_id)
      redirect_to admin_dashboards_path
    else
      render action: :new, locals: { sites: sites }
    end
  end

  private

  def site_id
    permitted_params.fetch(:site_id)
  end

  def permitted_params
    params.permit(:site_id)
  end

  def sites
    @sites ||= Site.all
  end
end
