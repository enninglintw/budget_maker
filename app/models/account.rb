class Account < ActiveRecord::Base

  def balance_in_twd
    (balance * exchange_rate).round
  end

end
