class CreateRoleUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :role_users, id: :uuid do |t|
      t.references :role, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
