class SettelmentsController < ApplicationController

  def create
    Settelment.create(settelment_params.merge(paid_by_id: current_user.id, paid_date: Date.today))
    redirect_to root_path, notice: 'Settelment created successfully.'
  end

  def owed_amount
    owe_amount = SplitExpense.joins(:expense).where(expenses: { paid_by_id: params[:user_id], paid: false },
                                                    split_expenses: { user_id: current_user.id, full_paid: false }).sum(:remaining_amount)
    render json: { owe_amount: owe_amount }
  end

  protected

  def settelment_params
    params.require(:settelment).permit(:amount, :paid_to_id, :description)
  end
end
