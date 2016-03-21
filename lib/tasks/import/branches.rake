require 'csv'

namespace :import do
  task branches: :environment do
    filename = "data/library_branch.csv"
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
