class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.datetime :startDate
      t.datetime :endDate
      t.string   :state
      t.bigint :employee

      t.timestamps
    end
  end
end
