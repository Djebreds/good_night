# frozen_string_literal: true

module Api
  # Handles user follows API
  class FollowsController < ApplicationController
    before_action :require_authentication
    before_action :find_user

    # POST /api/users/:user_id/follow
    def create
      Current.user.followees << @user

      render :create, status: :created
    end

    private

    def find_user
      @user = User.find(params[:user_id])
    end
  end
end
