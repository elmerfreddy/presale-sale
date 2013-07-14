class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :owner
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
