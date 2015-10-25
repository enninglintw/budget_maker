module Admin::AccountsHelper

  def render_currency(account)
    account.currency.upcase
  end

  def render_balance(account)
    number_to_currency(account.balance,
                       precision: 5,
                       strip_insignificant_zeros: true)
  end

  def render_exchange_rate(account)
    number_with_precision(account.exchange_rate,
                          precision: 5,
                          strip_insignificant_zeros: true)
  end

  def render_balance_in_twd(account)
    number_to_currency(account.balance_in_twd,
                       precision: 0)
  end

end
