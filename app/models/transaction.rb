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

  validates_presence_of :account_id, :date, :type, :amount

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
    type == "Transfer"
  end

  def income?
    type == "Income"
  end

  def expense?
    type == "Expense"
  end

  def detail
    if transfer?
      type + "(to #{transfer_account.try(:name)})"
    else
      type + "(#{try(:category)})"
    end
  end

end
