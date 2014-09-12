class SoundsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :create, :show]

  def index
    @sound = Sound.new

    @sound.echo = params[:echo]
    @sounds = if params[:latitude] && params[:longitude] 
       Sound.near([params[:latitude], params[:longitude]], 0.7, ASC)
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
   # assign_location
  end

  def create_via_blob
    @sound = Sound.new
    @sound.user_id = current_user.id
    @sound.echo = params[:echo]
    @sound.save
    render :js => "window.location = '/sounds/#{@sound.id}/edit'"
  end

  def create
    @sound = Sound.new(sound_params)
    @sound.user = current_user
    @sound.echo = params[:echo]

    if @sound.save
      render :js => "window.location = '/sounds/#{@sound.id}'"
    else
      render action: 'new'   
    end
  end

  def show
    @sound = Sound.find(params[:id])
    @nearby_sounds = @sound.nearbys(2, :units => :km)


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

  private

  def sound_params
    params.require(:sound).permit(:name, :description, :latitude, :longitude, :sound_url)
  end

  # def assign_location
  #   location = request.location
  #   @sound.latitude = location.latitude
  #   @sound.longitude = location.longitude    
  # end

end



