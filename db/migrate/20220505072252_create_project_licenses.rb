class CreateProjectLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :project_licenses do |t|
      t.references :project, null: false, foreign_key: true
      t.references :license, null: false, foreign_key: true

      t.timestamps
    end
    add_index  :project_licenses, [:project_id, :license_id], unique: true
  end
end
