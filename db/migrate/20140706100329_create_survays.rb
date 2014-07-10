class CreateSurvays < ActiveRecord::Migration
  def change
    create_table :survays do |t|
      t.text :question

      t.timestamps
    end
  end
end
