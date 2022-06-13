class CreateUserAllowances < ActiveRecord::Migration[6.1]
  def change
    create_table :user_allowances do |t|
      t.references :user, null: false, foreign_key: true
      t.references :license, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :price
      t.date :date

      t.timestamps
    end
  end
end
