class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles, id: :uuid do |t|
      t.references :site, foreign_key: true, index: true, type: :uuid
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
