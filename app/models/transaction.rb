# == Schema Information
#
# Table name: transactions
#
#  id                     :integer          not null, primary key
#  account_id             :integer
#  counterpart_id         :integer
#  counterpart_account_id :integer
#  origin_id              :integer
#  date                   :date
#  type                   :string(255)
#  category               :string(255)
#  note                   :text(65535)
#  amount                 :decimal(20, 5)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Transaction < ActiveRecord::Base

  validates_presence_of :account_id, :date, :type, :amount

  belongs_to :account, counter_cache: true

  has_one    :counterpart_to,   foreign_key: "counterpart_id",
                                class_name:  "Transaction"
  belongs_to :counterpart_from, foreign_key: "counterpart_id",
                                class_name:  "Transaction",
                                dependent:   :destroy

  after_save :create_counterpart, if: :transfer?, unless: "counterpart.present?"

  scope :transfers, -> { where(type: 'Transfer') }
  scope :incomes,   -> { where(type: 'Income') }
  scope :expenses,  -> { where(type: 'Expense') }

  def transfer?() type == "Transfer" end
  def income?()   type == "Income"   end
  def expense?()  type == "Expense"  end

  def previous
    self.class.
         where(account_id: account_id).
         where("id < ?", id).
         last
  end

  def current_transactions
    self.class.
         where(account_id: account_id).
         where("id <= ?", id)
  end

  def current_balance
    current_transactions.inject(account.init_balance) do |sum, transaction|
      sum + transaction.amount
    end
  end

  def detail
    sub_detail =
      if transfer?
        from_or_to = (amount >= 0) ? "from" : "to"
        [from_or_to, " ", counterpart.account.name].join("")
      else
        category
      end
    [type, " (", sub_detail, ")"].join("")
  end

  # methods for Transfer only
  def counterpart
    counterpart_to || counterpart_from
  end

  def counterpart_attributes
    {account_id: counterpart_account_id,
     counterpart_account_id: account_id,
     counterpart_id: id,
     date: date,
     type: type,
     note: note,
     amount: -amount}
  end

  private

  def create_counterpart
    create_counterpart_to(counterpart_attributes)
    update(counterpart_id: counterpart.id)
  end

end
