class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.text :action
      t.integer :initiative_id

      t.timestamps
    end
  end
end
