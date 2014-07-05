class AddMoreinfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :gender, :string
  	add_column :users, :date_of_birth, :string
  	add_column :users, :national_id, :string
  	add_column :users, :location, :string
  end
end
