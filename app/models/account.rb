class Account < ActiveRecord::Base

  validates_presence_of :name, :currency, :exchange_rate, :init_balance

  def self.net_assets_in_twd
    all.map(&:balance_in_twd).inject(:+)
  end

  def self.sum_balance_in(currency)
    where(currency: currency).map(&:balance).inject(:+)
  end

  def balance_in_twd
    (balance * exchange_rate).round
  end

  def balance
    init_balance
  end

end
