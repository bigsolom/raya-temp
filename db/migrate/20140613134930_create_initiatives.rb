class CreateInitiatives < ActiveRecord::Migration
  def self.up
    create_table :initiatives do |t|
      t.string :title
      t.text :description
      t.text :image
      t.integer :sector_id
      t.integer :region_id
      t.integer :user_id

      t.timestamps
    end
  end
  
  def self.down
    drop_table :initiatives
  end
end
