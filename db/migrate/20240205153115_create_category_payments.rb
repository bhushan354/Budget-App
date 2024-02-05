class CreateCategoryPayments < ActiveRecord::Migration[7.1]
  def change
    create_table :category_payments do |t|
      # This line adds a reference column named "payment" to the "category_payments" table. This column is intended to store foreign 
      # keys that reference the "id" column in another table (presumably the "payments" table).
      t.references :payment, null: false, foreign_key: true
      # t.references :category implies that the "category" column in the "category_payments" table is a foreign key referencing the "id" column of the "categories" table.
      t.references :category, null: false, foreign_key: true
      #Rails assumes that :payment refers to the "payments" table because it uses the singular form "payment" and follows the convention that the associated table is the pluralized version of the symbol.

      # So, t.references :payment is equivalent to saying "create a foreign key that references the 'id' column of the 'payments' table."

      t.timestamps
    end
  end
end
