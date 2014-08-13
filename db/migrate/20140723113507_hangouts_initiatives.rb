class HangoutsInitiatives < ActiveRecord::Migration
  def change
  	create_table :hangouts_initiatives, id: false do |t|
      t.belongs_to :hangout
      t.belongs_to :initiative
    end
  end
end
