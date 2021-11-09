# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @users = if params[:id]&.present?
               User.find(params[:id]).includes(:friendships)
             else
               User.limit(20).includes(:friendships)
             end
  end

  def show
    @user = User.find params[:id]
    @requests = Friendship.where(friend: @user).pending.includes(:user)
  end

  def send_request
    friend = User.find params[:id]
    current_user.friendships.create(friend: friend)

    redirect_to profiles_url
  end

  def accept_request
    Friendship.find(params[:id]).update(accepted_at: DateTime.now)

    redirect_to profile_path(current_user)
  end

  def decline_request
    Friendship.find(params[:id]).update(rejected_at: DateTime.now)

    redirect_to profile_path(current_user)
  end
end
