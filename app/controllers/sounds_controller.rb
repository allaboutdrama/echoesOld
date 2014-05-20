class SoundsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :create, :show]

  def index
    @sounds = if params[:latitude] && params[:longitude] 
       Sound.near([params[:latitude], params[:longitude]], 0.5)
    else
      Sound.all    
    end
        
    respond_to do |format|
      format.html
      format.js 
    end  
  end

  def new
    @sound = Sound.new
    @sound.user = current_user
    location = request.location
    @sound.latitude = location.latitude
    @sound.longitude = location.longitude
  end

  def create
    @sound = Sound.new(user_params)
    @sound.user = current_user

    if @sound.save 
      redirect_to(:sounds, notice: 'Your echo has been created')
    else
      render action: 'new'   
    end
  end

  def show
    @sound = Sound.find(params[:id])
    @nearby_sounds = @sound.nearbys(1, :units => :km)
  end


  def edit
    @sound = Sound.find(params[:id])
  end

  def update
    @sound = Sound.find(params[:id])

    @sound.name = params[:sound][:name]
    @sound.sound_url = params[:sound] [:sound_url]
    @sound.description = params[:sound][:description]

    if @sound.save
      redirect_to @sound
    else
      render 'edit'
    end  

  end

  def destroy
    @sound = Sound.find(params[:id])
    @sound.destroy

    redirect_to sounds_path
  end
end


private
def user_params
  params.require(:sound).permit(:name, :description, :latitude, :longitude, :sound_url)
end