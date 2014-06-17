class RemoveImageFromInitiatives < ActiveRecord::Migration
  def change
    remove_column :initiatives, :image, :text
  end
end
