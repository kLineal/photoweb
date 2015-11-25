class CollectionPhotosController < ApplicationController

# Uses tags to generate partial and covering (disjoint) views of 
# the collection.
#
# The list of keywords are those from model CollectionTag
#

def new 

end

def index
  
  @all_tags = CollectionTag.all
  @ftags = []
  
  # show only photos filtered by tags,
  # and make the filter available to the view
  if params[:filter_by_tags_ids]
    
    params[:filter_by_tags_ids].each { |id| @ftags << id.to_i  }
    
    keywords = get_keywords(params[:filter_by_tags_ids])
    
    @photos = CollectionPhoto.tagged_with(keywords, :on => :keywords, :math_all => true)
    
  else @photos = CollectionPhoto.all  
  end

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
# names are given in params[:delete_tag_ids]

def update

  photo = CollectionPhoto.find(params[:id])
  
  # first remove then add (removing and adding a tag untouches it)
  if params[:delete_tags_ids]
    
    keywords = get_keywords(params[:delete_tags_ids])
    photo.keyword_list.remove(keywords)
      
  end
  
  if params[:tag_with_ids]
  
    keywords = get_keywords(params[:tag_with_ids])
    photo.keyword_list.add(keywords)
 
  end
  
  photo.save
  photo.reload
  redirect_to edit_collection_photo_path(photo)

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


def get_keywords ids
  tags = CollectionTag.find(ids)
  keywords = []
  tags.each { |tag| keywords << tag.keyword }
  keywords
end
end
