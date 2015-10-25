class Account < ActiveRecord::Base

  def self.net_assets_in_twd
    all.inject(0) { |sum, account| sum + account.balance_in_twd }
  end

  def self.sum_balance_in(currency)
    where(currency: currency).sum(:balance)
  end

  def balance_in_twd
    (balance * exchange_rate).round
  end

end
