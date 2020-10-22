class CreateOrganisations < ActiveRecord::Migration[5.2]
  def change
    create_table :organisations, id: :uuid do |t|
      t.string :name
      t.boolean :isolate_assets, default: true
      t.boolean :isolate_users, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
