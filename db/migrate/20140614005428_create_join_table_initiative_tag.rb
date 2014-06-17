class CreateJoinTableInitiativeTag < ActiveRecord::Migration
  def change
    create_join_table :initiatives, :tags do |t|
       t.index [:initiative_id, :tag_id]
       t.index [:tag_id, :initiative_id]
    end
  end
end
