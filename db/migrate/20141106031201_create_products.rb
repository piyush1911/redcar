class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :user
      t.string :title
      t.text :description
      t.string :integer
      t.string :price
      t.string :decimal

      t.timestamps
    end
  end
end
