class AddTableToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :table_id, :bigint
  end
end
