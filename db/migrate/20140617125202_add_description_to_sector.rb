class AddDescriptionToSector < ActiveRecord::Migration
  def change
    add_column :sectors, :description, :string
  end
end
