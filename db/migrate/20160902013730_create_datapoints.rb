class CreateDatapoints < ActiveRecord::Migration
  def change
    create_table :datapoints do |t|
      t.references :data_type, index: true, foreign_key: true
      t.timestamp :value_timestamp
      t.float :value

      t.timestamps null: false
    end
  end
end
