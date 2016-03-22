require 'csv'

namespace :import do
  task loans: :environment do
    filename = "data/book_loans.csv"
    line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
    puts "Importing book loans"
    puts "Total: #{line_count}"
    i = 0
    ActiveRecord::Base.transaction do
      CSV.foreach(filename, headers: true, col_sep: "\t") do |row|
        book_id = Book.find_by(isbn10: row["isbn"]).id
        borrower_id = Borrower.find_by(card_no: row["card_no"]).id
        loan_hash = {
          book_id: book_id,
          branch_id: row["branch_id"].to_i,
          borrower_id: borrower_id,
          date_out: row["date_out"],
          due_date: row["due_date"],
          date_in: row["date_in"],
        }
        Loan.create(loan_hash)
        i += 1
        puts i if i % 1000 == 0
      end
    end
  end
end
