class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :paid_expenses, foreign_key: :paid_by_id, class_name: 'Expense'
  has_many :created_expenses, foreign_key: :created_by_id, class_name: 'Expense'
  has_many :split_expenses
end
