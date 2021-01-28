class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.string :name
      t.decimal :total
      t.string :token

      t.timestamps
    end
  end
end
