class AddZipcodeToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :zipcode, :string
  end
end
