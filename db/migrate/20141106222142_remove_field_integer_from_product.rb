class RemoveFieldIntegerFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :integer
  end
end
