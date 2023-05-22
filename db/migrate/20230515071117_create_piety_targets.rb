class CreatePietyTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :piety_targets do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
