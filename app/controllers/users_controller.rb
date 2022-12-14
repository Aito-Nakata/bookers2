class UsersController < ApplicationController
  before_action :autheniticate_user, {only: [:index, :show, :edit, :create, :update, :destroy]}
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      flash[:notice] = "Book was successfully updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(current_user.id)) unless current_user?(@user)
  end
  
  def current_user?(user)
    user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
