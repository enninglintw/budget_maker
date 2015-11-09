module Admin::AccountsHelper

  def render_net_assets_in_twd
    number_to_currency(Account.net_assets_in_twd,
                       precision: 0)
  end

  def render_sum_balance_in(currency)
    number_to_currency(Account.sum_balance_in(currency),
                       precision: 5,
                       strip_insignificant_zeros: true)
  end

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

  def render_updated_at(account)
    account.updated_at.
            to_date.
            to_formatted_s(:db)
  end

end
