# frozen_string_literal: true

module Api
  # Handles user follows API
  class FollowsController < ApplicationController
    before_action :require_authentication
    before_action :find_user, only: %i[create destroy]

    # GET /api/followers
    def follower
      @followers = Current.user.followees
      render :follower, status: :ok
    end

    # POST /api/users/:user_id/follow
    def create
      Current.user.followees << @user

      render :create, status: :created
    end

    # DELETE /api/users/:user_id/unfollow
    def destroy
      Current.user.followees.delete(@user)

      head :no_content
    end

    private

    def find_user
      @user = User.find(params[:user_id])
    end
  end
end
