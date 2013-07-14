class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :store, index: true

      t.timestamps
    end
  end
end
