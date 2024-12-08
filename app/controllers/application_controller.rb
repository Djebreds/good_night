# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from Exceptions::GoodNightError do |ex|
    render json: { code: ex.code, message: ex.message }, status: ex.status
  end

  rescue_from ActiveRecord::RecordNotFound do |ex|
    message = t('exceptions.not_found', context: ex.model)
    render json: { code: 404, message: }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |ex|
    message = t('exceptions.unprocessable_entity', record: ex.record.errors.full_messages.join(', '))
    render json: { code: 422, message: }, status: :unprocessable_entity
  end
end
