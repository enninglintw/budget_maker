module Admin::TransactionsHelper

  def render_date(transaction)
    transaction.date.to_formatted_s(:db)
  end

end
