class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates, id: :uuid do |t|
      t.references :site, foreign_key: true, type: :uuid
      t.string :name
      t.text :description
      t.string :filename
      t.json :metadata, default: {}

      t.timestamps
    end
  end
end
