require 'csv'

namespace :import do
  task borrowers: :environment do
    filename = "data/borrowers.csv"
    i = 0
    ActiveRecord::Base.transaction do
      CSV.foreach(filename, headers: true, col_sep: ",") do |row|
        borrowers_hash = {
          card_no: row["ID0000id"],
          ssn: row["ssn"],
          fname: row["first_name"],
          lname: row["last_name"],
          email: row["email"],
          address: row["address"],
          city: row["city"],
          state: row["state"],
          phone: row["phone"],
        }
        Borrower.create(borrowers_hash)
        i += 1
        puts i if i % 1000 == 0
      end
    end
  end
end
