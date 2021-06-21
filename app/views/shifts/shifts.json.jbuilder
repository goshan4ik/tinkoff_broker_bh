json.array! @requests do |request|
  json.id request.id
  json.startDate request.startDate
  json.endDate request.endDate
  json.state request.state
end