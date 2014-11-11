class RemoveFieldDecimalFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :decimal
    change_column :products, :price, :decimal, precision: 8, scale: 2
  end
end
