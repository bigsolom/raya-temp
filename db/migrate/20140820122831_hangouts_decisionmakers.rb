class HangoutsDecisionmakers < ActiveRecord::Migration
  def change
  	create_table :hangouts_decisionmakers, id: false do |t|
      t.belongs_to :hangout
      t.belongs_to :decisionmaker
    end
  end
end