class RenameDatapointsDataPoints < ActiveRecord::Migration
  def change
    rename_table :datapoints, :data_points
  end
end
