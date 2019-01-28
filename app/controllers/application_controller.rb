class ApplicationController < ActionController::Base
  def index
    @books = Book.all
  end
end
