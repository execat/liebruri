class Copies < ApplicationRecord
  belongs_to :book
  belongs_to :branch

  validates :book_id, presence: true
  validates :branch_id, presence: true
  validates :no_of_copies, numericality: { greater_than_or_equal_to: 0 }
end
