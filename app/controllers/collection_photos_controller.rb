class CollectionPhotosController < ApplicationController

# Uses tags to generate partial and covering (disjoint) views of 
# the collection.
#
# The list of keywords are those from model CollectionTag
#

def new 

end

def index
  
    @photos = CollectionPhoto.all
    
  end

def show
    
    @photo = CollectionPhoto.find(params[:id])
    
end

def create
    
  @photo = CollectionPhoto.new(photo_params)
  
  @photo.save
  
  redirect_to @photo
  
end


def slideshow 
  # There is now #show for collection_views controller.
  # Delete this action and its view (and the route in config/routes)
  # when appropriate.
  @route = CollectionPhoto.all
  
end

def destroy
  
  @photo=CollectionPhoto.find(params[:id])
  @photo.destroy
  redirect_to collection_photos_path
  
end


private

def photo_params #whitelists attribute 'name' of CollectionPhoto model
  
  params.require(:collection_photo).permit(:name)
  
end

end
