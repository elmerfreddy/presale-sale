class AddPriceToDetails < ActiveRecord::Migration
  def change
    add_column :details, :price, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
