class CreateLicenseUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :license_users do |t|
      t.references :license, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
