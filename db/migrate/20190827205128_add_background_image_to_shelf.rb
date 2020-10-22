class AddBackgroundImageToShelf < ActiveRecord::Migration[5.2]
  def change
    add_column :shelves, :background_image_url, :string
  end
end
