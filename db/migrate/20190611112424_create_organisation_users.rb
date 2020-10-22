class CreateOrganisationUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :organisation_users, id: :uuid do |t|
      t.references :organisation, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
