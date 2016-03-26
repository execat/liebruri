class Borrower < ApplicationRecord
  has_many :loans

  validates :fname, presence: true
  validates :lname, presence: true
  validates :ssn, presence: true, uniqueness: true
  validates :address, presence: true

  def full_name
    "#{fname} #{lname}"
  end
end
