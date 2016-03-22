class Fine < ApplicationRecord
  belongs_to :loan

  validates :loan_id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0, allow_blank: true }
  validates :paid, numericality: { greater_than_or_equal_to: 0, allow_blank: true  }
end
