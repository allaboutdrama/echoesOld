class SoundsController < ApplicationController
  def index
    @sounds = Sound.all 
  end

  def new
    @sound = Sound.new
  end

  def create
    @sound = Sound.new(user_params)

    if @user.save 
      redirect_to(:users, notice: 'Your echo has been created')
    else
      render action: 'new'  
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
