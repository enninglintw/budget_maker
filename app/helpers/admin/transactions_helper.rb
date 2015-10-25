module Admin::TransactionsHelper

  def render_date(transaction)
    transaction.date.to_formatted_s(:db)
  end

  def render_category(transaction)
    transfer_account_name =
      if transaction.transfer_account_id
        "(#{transaction.transfer_account.try(:name)})"
      else
        ""
      end
    transaction.category + transfer_account_name
  end

end
