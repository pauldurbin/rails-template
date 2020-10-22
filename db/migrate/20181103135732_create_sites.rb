class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :prefix, :urn
      t.jsonb :metadata, null: false, default: {}

      t.timestamps
    end
  end
end
