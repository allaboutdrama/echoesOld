class SoundsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :new, :create, :show]

  def index
    @sounds = if params[:search]
      Sound.near(params[:search], 1, units: :km)
    elsif params[:latitude] && params[:longitude] 
      Sound.near([params[:latitude], params[:longitude]], 1, units: :km)
    else
      Sound.all
    end
    @user_geo_lat = params[:latitude]
    @user_geo_long = params[:longitude]
    
    respond_to do |format|
      format.html
      format.js 
    end  
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
    @nearby_sounds = @sound.nearbys(1)
  end


  def edit
    @sound = Sound.find(params[:id])
  end

  def update
    @sound = Sound.find(params[:id])

    @sound.name = params[:sound][:name]
    @sound.description = params[:sound][:description]

    if @sound.save
      redirect_to @sound
    else
      render 'edit'
    end  

  end

  def destroy
  end
end


private
def user_params
  params.require(:sound).permit(:name, :description, :latitude, :longitude, :sound_url)
end