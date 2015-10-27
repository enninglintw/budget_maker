class Transaction < ActiveRecord::Base

  belongs_to :account

  def transfer_account
    Account.find(transfer_account_id) if transfer_account_id
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
    transfer_account_id.present?
  end

  def income
    amount if amount > 0
  end

  def expense
    amount if amount <= 0
  end

end
