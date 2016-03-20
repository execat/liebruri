require 'csv'
require 'people'

namespace :import do
  task books: :environment do
    filename = "data/books.csv"
    i = 0
    ActiveRecord::Base.transaction do
      CSV.foreach(filename, headers: true, col_sep: "\t") do |row|
        isbn13 = row["ISBN13"]
        title = row["Title"]
        authors = (row["Authro"] || "").split(',').map do |a|
          Author.create(author_hash_for a)
        end
        cover = row["Cover"]
        publisher = row["Publisher"]
        pages = row["Pages"].to_i rescue nil

        book_hash = {
          isbn: isbn13,
          title: title,
          cover: cover,
          publisher: publisher,
          pages: pages,
        }
        book = Book.create(book_hash)
        book.authors << authors
        i += 1
        puts i if i % 1000 == 0
      end
    end
  end
end

def author_hash_for author
  parser = People::NameParser.new
  name = parser.parse(author)
  return {
    title: name[:title],
    fname: name[:first],
    mname: name[:middle],
    lname: name[:last],
    suffix: name[:suffix],
  }
end
