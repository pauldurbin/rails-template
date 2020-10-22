class CreateRoleActions < ActiveRecord::Migration[5.2]
  def change
    create_table :role_actions, id: :uuid do |t|
      t.references :role, foreign_key: true, index: true, type: :uuid
      t.string :table
      t.string :action

      t.timestamps
    end
  end
end
