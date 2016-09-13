class AddZipcodeToDataPoints < ActiveRecord::Migration
  def change
    add_column :data_points, :zipcode, :string
  end
end
