# frozen_string_literal: true

# Abstract action
class AbstractAction

  def error_result(description)
    Hash['success', false, 'description', description]
  end

  def success_result
    Hash['success', true]
  end

end
