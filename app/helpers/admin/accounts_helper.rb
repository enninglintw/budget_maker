module Admin::AccountsHelper

  def render_currency(account)
    account.currency.upcase
  end

  def render_exchange_rate(account)
    number_with_precision(account.exchange_rate,
                          precision: 5,
                          strip_insignificant_zeros: true)
  end

end
