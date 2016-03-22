class CreateFines < ActiveRecord::Migration[5.0]
  def change
    create_table :fines do |t|
      t.references :loan, foreign_key: true
      t.decimal :amount, precision: 30, scale: 2
      t.boolean :paid

      t.timestamps
    end
  end
end
