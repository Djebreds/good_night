# frozen_string_literal: true

# Handles password reset mailer
class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail subject: t('auth.password_reset_mailer'), to: user.email_address
  end
end
