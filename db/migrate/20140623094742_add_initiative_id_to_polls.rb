class AddInitiativeIdToPolls < ActiveRecord::Migration
  def change
  	add_column :polls, :initiative_id, :integer
  end
end
