class Fine < ApplicationRecord
  belongs_to :loan

  validates :loan_id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :paid, numericality: { greater_than_or_equal_to: 0 }
end
