class InitiativesUsers < ActiveRecord::Migration
  def change
  	create_table :initiatives_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :initiative
    end
  end
end
