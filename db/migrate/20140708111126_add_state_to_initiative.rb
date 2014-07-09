class AddStateToInitiative < ActiveRecord::Migration
  def change
    add_column :initiatives, :state, :string
  end
end
