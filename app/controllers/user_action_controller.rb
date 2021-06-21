# frozen_string_literal: true

# User action controller
class UserActionController < ApplicationController

  def update
    action_name = request.query_parameters['action']
    result = perform_action(action_name, action_params(action_name))
    if result['success']
      render body: nil, status: :ok
    else
      error = Hash['description', result['description']]
      render body: error.to_json, status: :bad_request
    end
  end

  private

  def possible_actions
    raise NotImplementedError
  end

  def action_params(action_name)
    raise NotImplementedError
  end

  def perform_action(action_name, params)
    unless possible_actions.key?(action_name)
      return Hash['success', false, 'description', 'Параметр action не найден или имеет некорректное значение']
    end

    possible_actions[action_name].perform(params)
  end

end
