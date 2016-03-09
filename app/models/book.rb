class Book < ApplicationRecord
  has_and_belongs_to_many :authors

  validates :isbn, presence: true
  validates :title, presence: true
end
