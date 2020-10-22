class CreateShelves < ActiveRecord::Migration[5.2]
  def change
    create_table :shelves, id: :uuid do |t|
      t.references :page, foreign_key: true, type: :uuid
      t.integer :position
      t.string :name
      t.string :css_class
      t.string :css_id
      t.references :template, foreign_key: true, type: :uuid
      t.json :metadata

      t.timestamps
    end
  end
end
