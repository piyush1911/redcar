class RemoveFieldIntegerFromSite < ActiveRecord::Migration
  def change
    remove_column :sites, :integer
  end
end
