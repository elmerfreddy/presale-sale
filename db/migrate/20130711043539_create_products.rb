class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
