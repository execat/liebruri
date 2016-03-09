class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :cover
      t.string :publisher
      t.integer :pages

      t.timestamps
    end
    add_index :books, :isbn, unique: true
    add_index :books, :title
  end
end
