class FavoritesController < ApplicationController

  def create
    book= Book.find(params[:book_id])
    favorite = current_user.favorite.new(book_id: book.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    book= Book.find(params[:book_id])
    favorite = current_user.favorite.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referer
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
