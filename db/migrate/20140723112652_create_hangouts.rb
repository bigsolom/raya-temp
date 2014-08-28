class CreateHangouts < ActiveRecord::Migration
  def change
    create_table :hangouts do |t|
      t.date :start_date
      t.integer :user_id

      t.timestamps
    end
  end
end
