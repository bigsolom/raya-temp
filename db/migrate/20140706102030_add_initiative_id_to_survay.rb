class AddInitiativeIdToSurvay < ActiveRecord::Migration
  def change
  	add_column :survays, :initiative_id, :integer
  end
end
