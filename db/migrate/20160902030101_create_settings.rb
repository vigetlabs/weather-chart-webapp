class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.references :data_type, index: true, foreign_key: true
      t.integer :x_res
      t.integer :now
      t.string :position
      t.string :light

      t.timestamps null: false
    end
  end
end
