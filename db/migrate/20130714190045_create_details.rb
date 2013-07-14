class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.belongs_to :product, index: true
      t.belongs_to :transaction, index: true
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
