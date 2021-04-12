class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def not_found_error
    head 404, content_type: 'text/plain'
  end
end
