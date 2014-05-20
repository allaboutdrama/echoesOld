class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :new, :create]

  def index
    @users = User.all

    @user_geo_lat = params[:latitude]
    @user_geo_long = params[:longitude]
    
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
  @user = User.find(params[:id])
end


def update
  @user = User.find(params[:id])

  @user.name = params[:user][:name]
  @user.email = params[:user][:email]
  @user.city = params[:user][:city]
  @user.country = params[:user][:country]
  @user.description = params[:user][:description]
  @user.password = params[:user][:password]
  @user.password_confirmation = params[:user][:password_confirmation]


  if @user.save
    redirect_to @user
  else
    render 'edit'
  end  
end

def destroy
end

private 

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation, :city, :country, :latitude, :longitude)
end

end






