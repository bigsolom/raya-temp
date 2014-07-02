class QuestionsUsers < ActiveRecord::Migration
  def change
  	create_table :questions_users do |t|
      t.integer :questions_id
      t.integer :user_id
	  end
  end
end

