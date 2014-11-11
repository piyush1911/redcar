class AddProductSite < ActiveRecord::Migration
  def change
    add_reference :products, :site, index: true
  end
end
