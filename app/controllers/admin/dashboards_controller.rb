class Admin::DashboardsController < Admin::AuthController
  def show
    render action: :show, locals: {}
  end
end
