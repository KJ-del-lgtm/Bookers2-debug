class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def show
    @book = Book.find(params[:id])
    @post_comment= PostComment.new
    @favorite =Favorite.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @post_comment=PostComment.all
    
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books=Book.all
      @user=current_user
     render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def is_matching_login_user
    book =Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
