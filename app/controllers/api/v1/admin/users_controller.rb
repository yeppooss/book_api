class Api::V1::Admin::UsersController < ApplicationController
  authorize_resource

  def show
    render json: User.find(params[:user_id])
  end
end
