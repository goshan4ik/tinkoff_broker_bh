# frozen_string_literal: true

require 'date'
require 'active_record/errors'
# Close request action
class CloseOrderAction < AbstractAction

  def perform(params)
    order_id = params['order_id']
    begin
      order = Order.find(order_id)
    rescue ActiveRecord::RecordNotFound
      return error_result("Заказ с id #{order_id} не найдена")
    end
    return error_result("Заказ с id #{order_id} уже завершен") if order.closed?

    close_date = DateTime.now
    cost = calc_order_cost(order, close_date)
    update_order(order, cost, close_date)
    success_result
  end

  private

  def calc_order_cost(order, close_date)
    spent_hours = calc_order_duration_in_hours(order.startDate.to_datetime, close_date)
    spent_hours * 450 * order.actions_count
  end

  def calc_order_duration_in_hours(start_date, end_date)
    hours = ((end_date - start_date) * 24).round
    minutes = ((end_date - start_date) * 24 * 60).round - 60 * hours
    hours += 1 if minutes > 10
    hours
  end

  def update_order(order, cost, end_date)
    update_result = order.update_attributes(sum: cost, endDate: end_date, state: 'closed')
    if update_result
      success_result
    else
      error_result("Произошла ошибка при обновлении заказа с id #{order.id}")
    end
  end

end
