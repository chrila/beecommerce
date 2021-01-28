class AddStateToPayment < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :state, :string
  end
end
