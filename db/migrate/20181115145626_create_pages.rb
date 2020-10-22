class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages, id: :uuid do |t|
      t.string :ancestry, index: true
      t.integer :ancestry_depth, default: 0

      t.string :meta_title
      t.string :meta_keywords
      t.string :meta_description
      t.string :menu_title
      t.string :slug
      t.string :override_url
      t.integer :pos
      t.jsonb :metadata, null: false, default: {}
      t.references :site, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
