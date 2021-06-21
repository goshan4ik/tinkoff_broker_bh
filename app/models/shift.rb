# frozen_string_literal: true

# Request
class Request < ApplicationRecord

  CLOSED_STATE = 'closed'

  def closed?
    state == CLOSED_STATE
  end
end
