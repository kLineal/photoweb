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

def edit
  
  @photo = CollectionPhoto.find(params[:id])
  @available_tags = CollectionTag.all

end

# either tag params[:id] with collection_tags 
# whose ids are given in params[:tag_with_ids]
#
# or delete tags from params[:id] whose
# names are given in params[:delete_tag_names]

def update

  photo = CollectionPhoto.find(params[:id])
  
  if params[:delete_tags_names]
    photo.keyword_list.remove(params[:delete_tags_names])
    photo.save
  end
  
  if params[:tag_with_ids]
  
    tags = CollectionTag.find(params[:tag_with_ids])
    keywords_to_append = []
    tags.each { |tag| keywords_to_append << tag.keyword }
      
    photo.keyword_list.add(keywords_to_append)
    photo.save
  
  end
  
  
  redirect_to edit_collection_photo_path(photo)
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

def photo_params 
# whitelists attributes
# 'name' CollectionPhoto model
# 'tag_list' of Tag model
  
  params.require(:collection_photo).permit(:name, :tag_list)
  
end

end
