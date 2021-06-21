# frozen_string_literal: true

require 'date'
# Requests Controller
class TablesController < UserActionController

  def get
    @tables = Table.all
  end

end
