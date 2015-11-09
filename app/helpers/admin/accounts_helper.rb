module Admin::AccountsHelper

  def render_currency(account)
    account.currency.upcase
  end

  def render_exchange_rate(account)
    number_with_precision(account.exchange_rate,
                          precision: 5,
                          strip_insignificant_zeros: true)
  end

  def render_info(account)
    currency      = render_currency(account)
    balance       = render_number_to_currency(account.balance)
    exchange_rate = render_exchange_rate(account)
    "#{currency} #{balance} (exchange_rate: #{exchange_rate})"
  end

end
