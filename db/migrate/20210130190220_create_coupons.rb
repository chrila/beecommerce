class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.decimal :value
      t.boolean :percent
      t.string :code

      t.timestamps
    end
  end
end
