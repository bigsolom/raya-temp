class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
	t.text :decision

      	t.timestamps
    end
  end
end
