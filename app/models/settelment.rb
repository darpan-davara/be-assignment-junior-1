class Settelment < ApplicationRecord
  belongs_to :paid_to, class_name: 'User'
  belongs_to :paid_by, class_name: 'User'

  after_create :set_split_expenses_as_paid

  def set_split_expenses_as_paid
    split_expenses = SplitExpense.joins(:expense).where(expenses: { paid_by_id: paid_to_id, paid: false },
                                                        split_expenses: { user_id: paid_by_id, full_paid: false }).order(date: :asc)
    rem_amount = amount
    split_expenses.each do |split_expense|
      if split_expense.remaining_amount <= rem_amount
        rem_amount -= split_expense.remaining_amount
        split_expense.update(remaining_amount: 0, full_paid: true, paid_date: Date.today)
      else
        split_expense.update(remaining_amount: split_expense.remaining_amount - rem_amount)
        rem_amount = 0
      end
      break if rem_amount.zero?
    end
  end
end
