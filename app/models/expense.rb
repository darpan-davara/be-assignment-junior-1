class Expense < ApplicationRecord
  attr_accessor :user_ids

  has_many :split_expenses
  belongs_to :paid_by, class_name: 'User'
  belongs_to :created_by, class_name: 'User'

  def self.create_with_split_user(params, current_user_id)
    author_id = params[:from_author].keys.first
    author_amount = params[:from_author].values.first
    expense = Expense.create(
      description: params[:description],
      date: params[:date],
      paid_by_id: author_id,
      created_by_id: current_user_id,
      amount: params[:amount],
      paid: false
    )
    SplitExpense.create_with_data(expense.id, author_id, author_amount, 0, true, Date.today)
    params[:split_user].to_h.each do |split_user|
      SplitExpense.create_with_data(expense.id, split_user.first, split_user.second, split_user.second)
    end
    expense
  end
end
