class AddIdentifierToDataTypes < ActiveRecord::Migration
  def change
    add_column :data_types, :identifier, :integer, :unique => true
  end
end
