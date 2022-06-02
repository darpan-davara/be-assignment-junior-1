class ExpensesController < ApplicationController

  def create
    Expense.create_with_split_user(expense_params, current_user.id)
    redirect_to root_path, notice: 'Expense was successfully created'
  end

  def index
    
  end

  protected

  def expense_params
    params.require(:expense).permit(:paid_by_id, :amount, :description, :date, from_author: {}, split_user: {})
  end

end
