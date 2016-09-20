class AddLocationKeyToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :location_key, :integer, default: 1
  end
end
