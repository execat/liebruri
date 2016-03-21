class CreateLoans < ActiveRecord::Migration[5.0]
  def change
    create_table :loans do |t|
      t.references :book, foreign_key: true
      t.references :branch, foreign_key: true
      t.references :borrower, foreign_key: true
      t.date :date_out
      t.date :date_in
      t.date :due_date

      t.timestamps
    end
  end
end
