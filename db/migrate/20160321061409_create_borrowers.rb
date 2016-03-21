class CreateBorrowers < ActiveRecord::Migration[5.0]
  def change
    create_table :borrowers do |t|
      t.string :card_no
      t.string :ssn
      t.string :fname
      t.string :lname
      t.string :email
      t.text :address
      t.string :city
      t.string :state
      t.string :phone

      t.timestamps
    end
    add_index :borrowers, :card_no, unique: true
    add_index :borrowers, :ssn, unique: true
  end
end
