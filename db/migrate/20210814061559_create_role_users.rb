class CreateRoleUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :role_users do |t|
      t.references :role, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
