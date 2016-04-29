class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    error!({errors: ['404: not found']}, 404)
  end

  def error!(body, status, *headers)
    render status: status, json: body
  end

end
