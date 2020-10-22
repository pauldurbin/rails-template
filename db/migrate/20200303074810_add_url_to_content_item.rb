class AddUrlToContentItem < ActiveRecord::Migration[5.2]
  def change
    add_column :content_items, :url, :string
  end
end
