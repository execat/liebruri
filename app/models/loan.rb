class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :branch
  belongs_to :borrower

  validates :book_id, presence: true
  validates :branch_id, presence: true
  validates :borrower_id, presence: true
  validates :due_date, presence: true
  validates :date_in, presence: true
end
