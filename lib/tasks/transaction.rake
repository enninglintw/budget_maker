require "csv"

namespace :transaction do
  desc "import transaction from csv file"
  task import_transactions: :environment do
    file_path = "doc/transactions.csv"

    CSV.foreach(file_path, headers: :first_row) do |row|
      attributes = row.to_hash
      attributes.reject! { |_, value| value == nil }
      attributes.each { |_, value| value.strip! }
      puts "Create or update transaction: #{attributes}."

      origin_id = attributes.delete("origin_id")
      Transaction.transaction do
        transaction = Transaction.find_or_initialize_by(origin_id: origin_id)
        transaction.update(attributes)
      end
    end

    puts "Done!"
  end
end
