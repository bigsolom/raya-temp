class InitiativesResults < ActiveRecord::Migration
  def change
	create_table :initiatives_results, id: false do |t|
		  t.belongs_to :initiative
		  t.belongs_to :result
	  end
  end
end
