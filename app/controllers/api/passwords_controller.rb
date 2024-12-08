# frozen_string_literal: true

module Api
  # Handles password reset API
  class PasswordsController < ApplicationController
    skip_before_action :require_authentication, only: %i[create update]

    before_action :set_user_by_token, only: :update

    # POST /api/passwords
    def create
      user = User.find_by(email_address: params[:email_address])

      raise ActiveRecord::RecordNotFound, user unless user

      PasswordsMailer.reset(user).deliver_later

      render json: { message: I18n.t('auth.password_reset_instruction') }, status: :ok
    end

    # PUT /api/passwords
    def update
      unless @user.update(password_params)
        raise Exceptions::GeneralError.new(I18n.t('exceptions.password_invalid'), :unprocessable_entity, 422)
      end

      render json: { message: I18n.t('auth.password_reset_success') }, status: :ok
    end

    private

    def set_user_by_token
      # rubocop:disable Rails/DynamicFindBy
      @user = User.find_by_password_reset_token!(params[:token])
      # rubocop:enable Rails/DynamicFindBy
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::GeneralError.new(I18n.t('exceptions.expired_password_reset'), :not_found, 404)
    end

    def password_params
      params.permit(:password, :password_confirmation)
    end
  end
end
