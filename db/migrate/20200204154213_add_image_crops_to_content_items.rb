class AddImageCropsToContentItems < ActiveRecord::Migration[5.2]
  def change
    add_column :content_items, :background_image_crop, :jsonb
    add_column :content_items, :foreground_image_crop, :jsonb
  end
end
