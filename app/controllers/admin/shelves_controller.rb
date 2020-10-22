class Admin::ShelvesController < Admin::AuthController
  def index
    render action: :index, locals: { shelves: shelves } 
  end

  def new
    render action: :new, locals: { shelf: new_shelf, templates: templates }
  end

  def create
    page.shelves.new(permitted_params).tap do |shelf|
      if shelf.save
        respond_to do |format|
          format.html { redirect_to admin_page_shelf_path, notice: 'Shelf created' }
          format.js { render action: :create, locals: { page: page } }
        end
      else
        render action: :new, locals: { shelf: shelf, templates: templates }
      end
    end
  end

  def edit
    render action: :edit, locals: { shelf: shelf, templates: templates }
  end

  def update
    if shelf.update_attributes(permitted_params)
      shelf.background_image.purge if shelf.remove_background_image?

      respond_to do |format|
        format.html { redirect_to admin_page_shelf_path, notice: 'Shelf updated' }
        format.js { render action: :update, locals: { page: page } }
      end
    else
      render action: :edit, locals: { shelf: shelf, templates: templates }
    end
  end

  def destroy
    page = shelf.page
    shelf.destroy
    respond_to do |format|
      format.html { redirect_to edit_admin_page_path(page.id), notice: 'Shelf removed' }
      format.js { render action: :destroy, locals: { page: page } }
    end
  end

  def select_or_create
  end

  private

  def shelves
    @shelves ||= Shelf.includes(:template, :page).order('pages.menu_title').all
  end

  def new_shelf
    return shelf.dup if params[:id].present?
    page.shelves.new
  end

  def shelf
    @shelf ||= Shelf.includes(:template).find(params[:id])
  end

  def templates
    @templates ||= current_site.templates
  end

  def page
    @page ||= Page.includes(shelves: :template).find(params[:page_id])
  end

  def permitted_params
    params.require(:shelf).permit(
      :page, :position, :name, :css_class,
      :css_id, :template_id, :metadata_raw,
      :background_image, :remove_background_image,
      :background_image_crop
    )
  end
end
