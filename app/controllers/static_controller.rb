class StaticController < ApplicationController
  def dashboard
    @users = User.all
    @expense = Expense.new
    you_owe_split_expenses = SplitExpense.where(full_paid: false, user_id: current_user.id).includes(:expense, :paid_by)
    @you_owe_users = you_owe_split_expenses.group_by { |split_expense| split_expense.expense.paid_by }
    @you_owe = you_owe_split_expenses.sum(:remaining_amount)
    paid_by_expenses = Expense.where(paid: false, paid_by_id: current_user.id)
    you_owed_split_expenses = SplitExpense.where(expense_id: paid_by_expenses.ids, full_paid: false).includes(:user)
    @you_owed = you_owed_split_expenses.sum(:remaining_amount)
    @you_owed_users = you_owed_split_expenses.group_by(&:user)
  end

  def person
  end
end
