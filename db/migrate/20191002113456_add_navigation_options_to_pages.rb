class AddNavigationOptionsToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :show_in_header, :boolean, default: false
    add_column :pages, :show_in_footer, :boolean, default: false
  end
end
