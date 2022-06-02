#

class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.text :description, null: false
      t.date :date, null: false
      t.bigint :paid_by_id, null: false
      t.bigint :created_by_id, null: false
      t.float :amount, null: false
      t.boolean :paid, default: false

      t.timestamps
    end
    add_index :expenses, :created_by_id
    add_index :expenses, :paid_by_id
  end
end
