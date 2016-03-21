class AddIsbn10ToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :isbn10, :string
  end
end
