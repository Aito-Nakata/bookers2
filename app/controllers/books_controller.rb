class BooksController < ApplicationController
  before_action :autheniticate_user, {only: [:index, :show, :edit, :update]}
  before_action :ensure_user, only: [:edit, :update, :destroy]

  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id]) # 登録書籍の詳細情報を含む変数
    @user = @book_show.user
    @book_comment = BookComment.new
  end

  def edit

  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  
  def ensure_user
    @books = current_user.books
    @book = @books.find_by(id: params[:id])
    redirect_to books_path unless @book
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
