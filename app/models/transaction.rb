# == Schema Information
#
# Table name: transactions
#
#  id                  :integer          not null, primary key
#  account_id          :integer
#  transfer_account_id :integer
#  origin_id           :integer
#  date                :date
#  type                :string(255)
#  category            :string(255)
#  note                :text(65535)
#  amount              :decimal(20, 5)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Transaction < ActiveRecord::Base

  belongs_to :account, counter_cache: true

  scope :transfers, -> { where(type: 'Transfer') }
  scope :incomes,   -> { where(type: 'Income') }
  scope :expenses,  -> { where(type: 'Expense') }

  def transfer_account
    Account.find(transfer_account_id) if transfer?
  end

  def previous
    self.class.
         where(account_id: account_id).
         where("id < ?", id).
         last
  end

  def current_transactions
    self.class.
         where(account_id: account_id).
         where("id <= ?", id)
  end

  def current_balance
    current_transactions.inject(account.init_balance) do |sum, transaction|
      sum + transaction.amount
    end
  end

  def transfer?
    category1 == "轉帳"
  end

  def transfer
    amount if transfer?
  end

  def income?
    category1 == "收入"
  end

  def income
    amount if income?
  end

  def expense?
    category1 == "支出"
  end

  def expense
    amount if expense?
  end

  def category
    if transfer?
      category1 + "(to #{transfer_account.try(:name)})"
    else
      category1 + "(#{try(:category2)})"
    end
  end

  class << self

    def sum_income
      where(category1: "收入").inject(0) do |sum, transaction|
        sum + transaction.income
      end
    end

    def sum_expense
      where(category1: "支出").inject(0) do |sum, transaction|
        sum + transaction.expense
      end
    end

    def sum_transfer
      where(category1: "轉帳").inject(0) do |sum, transaction|
        sum + transaction.transfer
      end
    end

  end

end
