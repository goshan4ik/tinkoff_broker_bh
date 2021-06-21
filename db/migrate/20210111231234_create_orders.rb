class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.datetime :startDate
      t.datetime :endDate
      t.bigint :request
      t.integer :actions_count

      t.timestamps
    end
  end
end
