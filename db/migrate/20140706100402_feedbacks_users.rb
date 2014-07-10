class FeedbacksUsers < ActiveRecord::Migration
  def change
  	create_table :feedbacks_users, id: false do |t|
  		t.integer :feedback_id
  		t.integer :user_id
  		
  	end
  end
end
