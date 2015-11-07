class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :account_categories, :accounts

  def account_categories
    ["現金", "儲值", "活存", "信用卡", "投資"]
  end

  def accounts
    Account.all.order(:origin_id)
  end
end
