class PopulateController < ApplicationController
  include PopulateHelper
  skip_before_filter :verify_authenticity_token
  def update
    process_fill(get_event_text())
  end
end
