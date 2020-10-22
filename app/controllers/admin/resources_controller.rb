class Admin::ResourcesController < Admin::AuthController
  def index
    render :index, locals: { resources: resources }
  end

  def new
    render :new, locals: { resource: Resource.new }
  end

  def create
    respond_to do |format|
      current_site.resources.new(permitted_params).tap do |new_resource|
        if new_resource.save
          format.html { redirect_to admin_resources_path, notice: 'Resource created.' }
          format.js { render action: :create, locals: { resource: new_resource } }
        else
          format.js { render action: :new, locals: { resource: new_resource } }
        end
      end
    end
  end

  def edit
    render :edit, locals: { resource: resource }
  end

  def update
    if resource.update_attributes(permitted_params)
      redirect_to admin_resources_path, notice: 'Resource updated.'
    else
      render :edit, locals: { resource: resource }
    end
  end

  def show
    render :show, locals: { resource: resource }
  end

  def destroy
    if resource.destroy
      redirect_to admin_resources_path, notice: 'Resource successfully removed.'
    else
      redirect_to admin_resources_path, notice: 'Sorry, this resouce could not be removed.'
    end
  end

  private

  def permitted_params
    params.require(:resource).permit(:title, :description, :file, :active)
  end

  def resource
    @resource ||= current_site.resources.find(params[:id])
  end

  def resources
    @resources ||= current_site.resources.page(page_number).per(per_page)
  end

  def per_page
    @per_page ||= params.fetch(:per_page, 12)
  end
end
