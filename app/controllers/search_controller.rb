class SearchController < ApplicationController
  before_action :authenticate_user!
  def search
    if params[:word].nil?
      redirect_to request.referer
    else
      search = params[:search]
      @word = params[:word]
      @range = params[:range]
    if @range == '1'
      @user = User.search(search,@word)
    elsif @range == '2'
      @book = Book.search(search,@word)
    else
      @user = User.all
    end
    end
  end
end
