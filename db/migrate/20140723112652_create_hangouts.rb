class CreateHangouts < ActiveRecord::Migration
  def change
    create_table :hangouts do |t|
      t.date :date
      t.integer :user_id
      t.text :user_type

      t.timestamps
    end
  end
end
