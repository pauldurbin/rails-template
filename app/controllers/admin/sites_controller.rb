class Admin::SitesController < Admin::AuthController
  before_action :site_selection, except: [ :new, :create ]

  def index
    render action: :index, locals: { sites: sites }
  end

  def new
    render action: :new, locals: { site: Site.new }
  end

  def create
    current_user.sites.new(permitted_params).tap do |site|
      if site.save
        redirect_to sites_path, notice: 'Site created.'
      else
        render :new, locals: { site: site }
      end
    end
  end

  def edit
    render action: :edit, locals: { site: site }
  end

  def update
    site.attributes = permitted_params

    if site.save
      redirect_to sites_path, notice: 'Site successfully updated.'
    else
      render :edit, locals: { site: site }
    end
  end

  def destroy
    if site.destroy
      flash[:notice] = 'Site successfully removed.'
    else
      flash[:error] = 'Site could not be removed at this time.'
    end
    redirect_to sites_path
  end

  private

  def permitted_params
    params.require(:site).permit(
      :name, :description, :prefix, :metadata
    )
  end

  def sites
    @sites ||= policy_scope(Site)
  end

  def site
    @site ||= Site.find(params[:id])
  end
end
