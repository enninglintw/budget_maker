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

class Expense < Transaction
  validates_presence_of :category
end
