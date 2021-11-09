# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @users = if params[:username]&.present?
               User.where(username: params[:username])
             else
               User.limit(20)
             end
  end

  def show
    @user = User.find_by! username: params[:username]
  end

  def send_request
    friend = User.find params[:id]
    current_user.friendships.create(friend: friend)

    redirect_to profiles_url
  end
end
