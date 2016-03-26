class Book < ApplicationRecord
  has_and_belongs_to_many :authors

  validates :isbn, presence: true
  validates :title, presence: true

  has_many :copies, foreign_key: "book_id", class_name: "Copies"
  has_many :branches, through: :copies
  has_many :loans
  has_many :fines, through: :loans
  has_many :borrowers, through: :loans

  def authors_string
    authors.pluck(:full_name).to_sentence
  end
end
