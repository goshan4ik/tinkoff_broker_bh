# frozen_string_literal: true

require 'date'
# Requests Controller
class RequestsController < UserActionController
  def requests
    @requests = if @current_user.role == 'admin'
                Request.all.order('id DESC')
              else
                Request.where(employee: @current_user.id).order('id DESC')
              end
  end

  def create
    if current_user_active_request?
      error = Hash['description', 'У вас уже есть активная смена']
      render body: error.to_json, status: :bad_request
    else
      start_date = DateTime.now
      request = Request.new(startDate: start_date, state: 'active', employee: @current_user.id)
      request.save
      render json: Hash['id', request.id].to_json
    end
  end

  private

  CLOSE_ACTION = 'close'

  def action_params(action_name)
    unless action_name != CLOSE_ACTION
      # TODO
    end
    Hash['request_id', params['id']]
  end

  def possible_actions
    Hash[CLOSE_ACTION, CloseRequestAction.new]
  end

  def current_user_active_request?
    !Request.where('employee = ? and state = ?', @current_user.id, 'active').empty?
  end
end
