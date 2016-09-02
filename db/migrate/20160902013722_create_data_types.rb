class CreateDataTypes < ActiveRecord::Migration
  def change
    create_table :data_types do |t|
      t.string :name
      t.integer :x_res
      t.integer :now
      t.string :position
      t.string :light

      t.timestamps null: false
    end
  end
end
