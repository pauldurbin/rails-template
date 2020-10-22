class CreateContentItems < ActiveRecord::Migration[5.2]
  def change
    create_table :content_items, id: :uuid do |t|
      t.references :shelf, foreign_key: true, type: :uuid
      t.integer :position
      t.string :name
      t.text :content
      t.string :css_class
      t.string :css_id
      t.json :metadata

      t.timestamps
    end
  end
end
