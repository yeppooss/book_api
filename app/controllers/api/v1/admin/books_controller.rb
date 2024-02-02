class Api::V1::Admin::BooksController < ApplicationController
  authorize_resource

  def index
    @books = User.find(params[:user_id]).books
    authorize! :read, @books

    render json: @books
  end

  def create
    @book = User.find(params[:user_id]).books.new(book_params)
    authorize! :create, @book

    if @book.save
      render json: @book, status: :created
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @book =  User.find(params[:user_id]).books.find(params[:id])
    @book.destroy
    render status: :no_content
  end

  private
  def book_params
    params.permit(:title, :description)
  end
end
