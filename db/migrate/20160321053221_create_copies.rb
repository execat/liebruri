class CreateCopies < ActiveRecord::Migration[5.0]
  def change
    create_table :copies do |t|
      t.references :book, foreign_key: true
      t.references :branch, foreign_key: true
      t.integer :no_of_copies

      t.timestamps
    end
  end
end
