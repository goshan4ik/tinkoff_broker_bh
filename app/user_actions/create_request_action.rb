# frozen_string_literal: true

require 'date'
require 'active_record/errors'
# Close request action
class CreateOrderAction < AbstractAction

  def perform(params)
    order_id = params['order_id']
    asset = params['asset']
    begin
      order = Order.create(asset)
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

  def calc_order_cost(count, active_cost)
    return count * active_cost
  end


  def update_order(order, cost, end_date)
    update_result = order.update_attributes(sum: cost, endDate: end_date, state: 'closed')
    if update_result
      success_result
    else
      error_result("Произошла ошибка при создании заявки с id #{order.id}")
    end
  end

end
