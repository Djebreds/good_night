# frozen_string_literal: true

module Api
  # Handles session API
  class SessionsController < ApplicationController
    skip_before_action :require_authentication, only: %i[create]

    rate_limit to: 10, within: 3.minutes, only: :create, with: lambda {
      raise Exceptions::GeneralError.new(I18n.t('exceptions.too_many_requests'), :too_many_requests, 429)
    }

    # POST /api/sessions
    def create
      user = User.authenticate_by(email_address: params[:email_address], password: params[:password])

      raise Exceptions::InvalidAuthError unless user

      session = user.sessions.find_or_initialize_by(ip_address: request.remote_ip)
      session.update!(user_agent: request.user_agent)

      render json: { token: session.token }, status: :created
    end

    # DELETE /api/sessions
    def destroy
      return head :unauthorized if Current.session.blank?

      Current.session.destroy
      Current.session = nil

      head :no_content
    end
  end
end
