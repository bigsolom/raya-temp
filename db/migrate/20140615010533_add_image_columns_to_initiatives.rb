class AddImageColumnsToInitiatives < ActiveRecord::Migration
  def self.up
    add_attachment :initiatives, :image
  end

  def self.down
    remove_attachment :initiatives, :image
  end
end
