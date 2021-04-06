class SearchController < ApplicationController
  before_action :authenticate_user!
  def search
    search = params[:search]
    @word = params[:word]
    @range = params[:range]
   if @range == '1'
    @user = User.search(search,@word)
   else
   @book = Book.search(search,@word)
   end
  end
end
