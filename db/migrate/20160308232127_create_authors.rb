class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :title
      t.string :fname
      t.string :mname
      t.string :lname
      t.string :suffix
      t.string :full_name

      t.timestamps
    end
  end
end
