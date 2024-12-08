# frozen_string_literal: true

# Provides authentication handling for controllers with session-based user tracking.
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    after_action :refresh_session
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private

  def require_authentication
    resume_session || render_unauthorized
  end

  def resume_session
    token = request.headers['Authorization']&.split&.last
    Current.session = Session.find_by(token: token)
  end

  def refresh_session
    return unless Current.session

    Current.session.regenerate_token!
    response.set_header('Authorization', "Bearer #{Current.session.token}")
  end

  def render_unauthorized
    raise Exceptions::GeneralError.new(I18n.t('exceptions.general.unauthorized'), :unauthorized, 401)
  end
end
