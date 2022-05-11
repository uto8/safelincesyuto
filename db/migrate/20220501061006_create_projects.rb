class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :date
      t.time :start_time
      t.time :end_time
      t.references :leader, foreign_key: { to_table: :users }, null: true
      t.string :address
      t.text :supplement

      t.timestamps
    end
  end
end
