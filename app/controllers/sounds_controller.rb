class SoundsController < ApplicationController
  def index
    @sounds = Sound.all 
  end

  def new
    @sound = Sound.new
  end

  def create
    @sound = Sound.new(user_params)

    if @sound.save 
      redirect_to(:sounds, notice: 'Your echo has been created')
    else
      render action: 'new'   
    end
  end

  def show
    @sound = Sound.find(params[:id])

  end

  def edit
  end

  def update
  end

  def destroy
  end
end


private
def user_params
  params.require(:sound).permit(:name, :description, :latitude, :longitude, :sound_url)
end