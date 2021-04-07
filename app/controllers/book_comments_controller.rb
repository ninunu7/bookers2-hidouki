class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    book_comment = BookComment.create(book_comment_params)
    redirect_to book_path(book_comment.book.id)
    @book_comment = BookComment.new
    @book_comments = @book.comments.includes(:user)
    if @book_comment.save
    respond_to do |format|
      format.json
    end
    else
    render book_path(@book_comment.book.id)
    end
  end




  def destroy
    @book = Book.find(params[:id])
    @book_comment = current_user.book_comments.find_by(book_id: @book.id)
    @book_comment.destroy
    redirect_to book_path(@book.id)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
