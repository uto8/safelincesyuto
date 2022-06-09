class CreateLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :licenses do |t|
      t.string :title
      t.integer :fee

      t.timestamps
    end
  end
end
