class CreateSiteUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :site_users, id: :uuid do |t|
      t.references :site, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
