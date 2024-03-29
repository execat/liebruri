require 'csv'

namespace :import do
  task copies: :environment do
    filename = "data/book_copies.csv"
    line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
    puts "Importing book copies"
    puts "Total: #{line_count}"
    i = 0
    ActiveRecord::Base.transaction do
      CSV.foreach(filename, headers: true, col_sep: "\t") do |row|
        book_id = Book.find_by(isbn10: row["book_id"]).id
        copies_hash = {
          book_id: book_id,
          branch_id: row["branch_id"],
          no_of_copies: row["no_of_copies"]
        }
        Copies.create(copies_hash)
        i += 1
        puts i if i % 1000 == 0
      end
    end
  end
end
