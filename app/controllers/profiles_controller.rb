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
  end

  def send_request
    friend = User.find params[:id]
    current_user.friendships.create(friend: friend)

    redirect_to profiles_url
  end
end
