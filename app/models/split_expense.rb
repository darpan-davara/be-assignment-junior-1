class SplitExpense < ApplicationRecord

  belongs_to :expense
  belongs_to :user
  has_one :paid_by, through: :expense
  has_one :created_by, through: :expense

  after_update :set_expense_as_paid

  def self.create_with_data(expense_id, author_id, split_amount, remaining_amount, paid = false, paid_date = nil)
    SplitExpense.create(
      expense_id: expense_id,
      user_id: author_id,
      full_paid: paid,
      paid_date: paid_date,
      split_amount: split_amount,
      remaining_amount: remaining_amount
    )
  end

  def set_expense_as_paid
    expense.update(paid: true) unless expense.split_expenses.pluck(:full_paid).any?(false)
  end
end
