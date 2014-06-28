class CreateDecisionmakers < ActiveRecord::Migration
  def change
    create_table :decisionmakers do |t|
      t.string :username
      t.string :name
      t.integer :password
      t.string :job
      t.string :image

      t.timestamps
    end
  end
end
