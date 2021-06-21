class Order < ApplicationRecord

  CLOSED_STATE = 'closed'

  def closed?
    state == CLOSED_STATE
  end

end
