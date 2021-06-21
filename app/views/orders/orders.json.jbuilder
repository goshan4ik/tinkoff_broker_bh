json.array! @orders do |order|
  json.id order.id
  json.table order.table_id
  json.startDate order.startDate
  json.state order.state
end