class AddSumToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :sum, :decimal
  end
end
