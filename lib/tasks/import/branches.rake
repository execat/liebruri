require 'csv'

namespace :import do
  task branches: :environment do
    filename = "data/library_branch.csv"
    line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
    puts "Importing branches"
    puts "Total: #{line_count}"
    i = 0
    ActiveRecord::Base.transaction do
      CSV.foreach(filename, headers: true, col_sep: "\t") do |row|
        branch_hash = {
          name: row["branch_name"],
          address: row["address"]
        }
        Branch.create(branch_hash)
        i += 1
        puts i if i % 1000 == 0
      end
    end
  end
end
