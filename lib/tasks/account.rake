require "csv"

namespace :account do
  desc "import account from csv file"
  task import_accounts: :environment do
    file_path = "doc/accounts.csv"

    CSV.foreach(file_path, headers: :first_row) do |row|
      attributes = row.to_hash
      attributes.reject! { |_, value| value == nil }
      attributes.each { |_, value| value.strip! }
      puts "Create or update account: #{attributes}."

      origin_id = attributes.delete("origin_id")
      Account.transaction do
        account = Account.find_or_initialize_by(origin_id: origin_id)
        account.update(attributes)
      end
    end

    puts "Done!"
  end
end
