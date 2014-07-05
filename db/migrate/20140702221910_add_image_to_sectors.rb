class AddImageToSectors < ActiveRecord::Migration
  def self.up
    add_attachment :sectors, :image
  end

  def self.down
    remove_attachment :sectors, :image
  end
end
