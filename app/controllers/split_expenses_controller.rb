class SplitExpensesController < ApplicationController
  
  def index
    @users = User.all
    @user = @users.find_by(id: params[:user_id])
    @expense = Expense.new
    @split_expenses = SplitExpense.where(user_id: @user.id, full_paid: false).includes(:expense, :paid_by)
    if current_user.id != @user.id
      @you_owe = SplitExpense.joins(:expense).where(expenses: { paid_by_id: @user.id, paid: false },
                                                    split_expenses: { user_id: current_user.id, full_paid: false }).sum(:remaining_amount)
      @you_owed = SplitExpense.joins(:expense).where(expenses: { paid_by_id: current_user.id, paid: false },
                                                     split_expenses: { user_id: @user.id, full_paid: false }).sum(:remaining_amount)
    end
  end
end
