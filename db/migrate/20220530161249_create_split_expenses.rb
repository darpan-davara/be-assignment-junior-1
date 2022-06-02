class CreateSplitExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :split_expenses do |t|
      t.bigint :expense_id, null: false
      t.bigint :user_id, null: false
      t.boolean :full_paid, default: false
      t.date :paid_date
      t.float :split_amount, null: false
      t.float :remaining_amount, null: false

      t.timestamps
    end
    add_index :split_expenses, :expense_id
    add_index :split_expenses, :user_id
  end
end
