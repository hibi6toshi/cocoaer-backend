class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :piety_target, null: false, foreign_key: true
      t.references :piety_category, null: false, foreign_key: true
      t.integer :days
      t.integer :cost
      t.string :title, null: false
      t.string :body, null: false
      t.string :picture

      t.timestamps
    end
  end
end
