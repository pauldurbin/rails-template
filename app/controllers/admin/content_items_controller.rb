class Admin::ContentItemsController < Admin::AuthController
  def index
    render action: :index, locals: { content_items: content_items } 
  end

  def new
    render action: :new, locals: { content_item: new_content_item }
  end

  def create
    shelf.content_items.new(permitted_params).tap do |content_item|
      if content_item.save
        respond_to do |format|
          format.html { redirect_to page_shelf_content_item_path, notice: 'Item created' }
          format.js { render action: :create, locals: { page: page } }
        end
      else
        render action: :new, locals: { content_item: content_item }
      end
    end
  end

  def edit
    render action: :edit, locals: { content_item: content_item }
  end

  def update
    if content_item.update_attributes(permitted_params)
      content_item.background_image.purge if content_item.remove_background_image?
      content_item.foreground_image.purge if content_item.remove_foreground_image?

      respond_to do |format|
        format.html { redirect_to page_shelf_content_item_path, notice: 'Item updated' }
        format.js { render action: :update, locals: { page: page } }
      end
    else
      render action: :edit, locals: { content_item: content_item }
    end
  end

  def destroy
    page = content_item.shelf.page
    content_item.destroy
    respond_to do |format|
      format.html { redirect_to edit_page_path(page.id), notice: 'Item removed' }
      format.js { render action: :destroy, locals: { page: page } }
    end
  end

  def select_or_create
  end

  private

  def content_item
    @content_item ||= ContentItem.find(params[:id])
  end

  def new_content_item
    return content_item.dup.tap do |c|
      c.shelf_id = params[:shelf_id]
    end if params[:id].present?
    shelf.content_items.new
  end

  def content_items
    @shelves ||= ContentItem.includes(shelf: :page).order('pages.menu_title').all
  end

  def shelf
    @shelf ||= Shelf.find(params[:shelf_id])
  end

  def page
    @page ||= Page.includes(shelves: [:template, :content_items]).find(params[:page_id])
  end

  def permitted_params
    params.require(:content_item).permit(
      :name, :content, :metadata_raw, :position,
      :css_class, :css_id, :background_image, :remove_background_image,
      :foreground_image, :remove_foreground_image, :background_image_crop,
      :foreground_image_crop, :url
    )
  end
end
