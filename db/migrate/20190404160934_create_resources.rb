class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources, id: :uuid do |t|
      t.references :site, foreign_key: true, type: :uuid
      t.string :title
      t.string :type
      t.text :description
      t.string :url
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
