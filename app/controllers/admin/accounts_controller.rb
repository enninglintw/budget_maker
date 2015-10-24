class Admin::AccountsController < ApplicationController

  def index
    @accounts = Account.all
  end

end
