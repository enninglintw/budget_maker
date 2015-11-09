class Account < ActiveRecord::Base

  validates_presence_of :name, :currency, :exchange_rate, :init_balance

  has_many :transactions

  def balance
    transactions.inject(init_balance) do |sum, transaction|
      sum + transaction.amount
    end
  end

  def balance_in_twd
    (balance * exchange_rate).round
  end

  class << self

    def all_currencies
      pluck(:currency).uniq
    end

    def balance(currency)
      where(currency: currency).map(&:balance).inject(:+)
    end

    def balance_in_twd(currency)
      where(currency: currency).map(&:balance_in_twd).inject(:+)
    end

  end

end
