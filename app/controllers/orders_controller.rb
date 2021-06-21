# frozen_string_literal: true

require 'date'
# Requests Controller
class OrdersController < UserActionController
  def orders
    request = if params.key?('id')
              params['id']
            else
              Request.find_by(employee: @current_user.id, state: 'active').id
            end
    @orders = Order.where('request = ?', request).order('id desc')
  end

  def create
    body = JSON.parse(request.raw_post)
    order_params = Hash['startDate', DateTime.now,
                        'table_id', body['table'],
                        'state', 'active',
                        'actions_count', body['actions_count'],
                        'request', params[:id]]
    @order = Order.new(order_params)
    @order.save
    render status: :created
  end

  private

  CLOSE_ACTION = 'close'

  def action_params(action_name)
    unless action_name != CLOSE_ACTION
      # TODO
    end
    Hash['order_id', params['id']]
  end

  def possible_actions
    Hash[CLOSE_ACTION, CloseOrderAction.new]
  end

end
