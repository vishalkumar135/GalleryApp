class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except:[:index, :show]
  before_action :authorize_item, only: [:update, :edit, :destroy]
 
 def  index

  if user_signed_in?
    @q = current_user.albums.published.ransack(params[:q])
    @albums = @q.result.includes(:tags)
  else
    @q = Album.ransack(params[:q])
    @albums = @q.result.includes(:tags)
       
  end 
end
  def show
  end

  def new
    
    @album = current_user.albums.new
  end
  def create
    
    @album = current_user.albums.build(album_params)

    if @album.save
      redirect_to @album , notice: 'Your album is successfully created'
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def edit    
  end
  
  def update

    if @album.update(album_params)
      redirect_to @album, notice: 'Your album  is  successfully updated'
    else
      render :edit,status: :unprocessable_entity 
    end
  end
  def draft
          
   @q= current_user.albums.unpublished. ransack(params[:q])
   @albums = @q.result.includes(:tags)
  end

   def destroy
    @album.destroy
    redirect_to root_path, status: :see_other ,notice: 'Your album  is  successfully deleted'
   end

   def purge_cover_photo
   @album=Album.find(params[:id])
   @album.cover_photo.purge
   redirect_back(fallback_location: request.referer)
  end
  def delete_image_attachment
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @image.attachments.first.purge
    redirect_back(fallback_location: request.referer)
  end
 
  
  private

  def authorize_item
    unless @album.user == current_user 
      redirect_to albums_path, notice: 'I am sorry but you are not authorized!'
    end
  end

  def set_album
    @album = Album.find(params[:id])
  end 

  def album_params
    params.require(:album).permit(:title, :Description,:user_id, :cover_photo, :published,:username, :all_tags, images:[])
  end
 
end


