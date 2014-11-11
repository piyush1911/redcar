class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.belongs_to :user
      t.string :alias
      t.string :title
      t.text :description
      t.string :integer

      t.timestamps
    end
  end
end
