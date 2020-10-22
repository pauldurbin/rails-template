class Admin::PagesController < Admin::AuthController
  include SortableTreeController::Sort
  sortable_tree 'Page', { parent_method: 'parent', sorting_attribute: 'pos' }

  def index
    authorize pages, :show?
    render action: :index, locals: { pages: pages.blank? ? [] : pages.arrange(order: :pos) }
  end

  def new
    render action: :new, locals: { page: page, pages: pages }
  end

  def create
    current_site.pages.new(permitted_params).tap do |p|
      p.parent = nil unless p.parent.present?
      if p.save
        redirect_to admin_pages_path, notice: 'Page has been created.'
      else
        render action: :new, locals: { page: p, pages: pages }
      end
    end
  end

  def edit
    render action: :edit, locals: { page: page, pages: pages }
  end

  def update
    if page.update_attributes(permitted_params)
      redirect_to admin_pages_path, notice: 'Page has been updated.'
    else
      Rails.logger.info("INSPECT: #{page.errors.inspect}")
      render action: :edit, locals: { page: page, pages: pages }
    end
  end

  def destroy
    if page.destroy
      redirect_to admin_pages_path, notice: 'Page has been removed.'
    else
      redirect_to admin_pages_path, error: 'Page could not be removed.'
    end
  end

  private

  def permitted_params
    params.require(:page).permit(
      :ancestry, :menu_title, :slug, :override_url, :meta_title,
      :meta_description, :meta_keywords, :metadata_raw,
      :show_in_header, :show_in_footer
    )
  end

  def page
    @page = if params[:id].blank?
      Page.new
    else
      Page.find(params[:id])
    end
  end

  def pages
    @pages ||= current_site.pages.all
  end
end
