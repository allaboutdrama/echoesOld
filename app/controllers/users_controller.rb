class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)

    if @user.save 
      login(@user.email, user_params[:password])
      redirect_to(user_path(@user), notice: 'Welcome to the World of Echoes')
    else
      render action: 'new'  
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end