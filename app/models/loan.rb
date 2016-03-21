class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :branch
  belongs_to :borrower
end
