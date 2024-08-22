# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from StandardError, with: :handle_exception

  def record_not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  def record_invalid(_exception)
    render json: { error: 'Invalid record' }, status: :unprocessable_entity
  end

  def handle_exception(exception)
    render json: { error: exception.message.to_s }, status: :internal_server_error
  end
end
