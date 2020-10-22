class AddBackgroundImageToContentItem < ActiveRecord::Migration[5.2]
  def change
    add_column :content_items, :background_image_url, :string
  end
end
