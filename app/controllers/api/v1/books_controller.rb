class Api::V1::BooksController < ApplicationController
  load_and_authorize_resource
  def index
    render json: @books
  end
end
