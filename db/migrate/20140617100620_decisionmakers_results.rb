class DecisionmakersResults < ActiveRecord::Migration
  def change
create_table :decisionmakers_results, id: false do |t|
		  t.belongs_to :result
		  t.belongs_to :decisionmaker
	  end
  end
end
