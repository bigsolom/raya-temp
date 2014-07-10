class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :answer
      t.integer :survay_id

      t.timestamps
    end
  end
end
