class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :piety_target, null: false, foreign_key: true
      t.references :piety_category, null: false, foreign_key: true
      t.date :limit_day
      t.integer :cost
      t.string :title, null: false
      t.string :body

      t.timestamps
    end
  end
end
