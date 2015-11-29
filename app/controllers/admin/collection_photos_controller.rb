class Admin::CollectionPhotosController < ApplicationController

# Photos are tagged with keywords (from collection_tags table) 
# This allows to render partial and disjoint (covers) views of 
# the collection.

def new 

end

# GET 'admin/collection_photos'
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


# 'GET admin/collection_photos/:id'
def show
    
    @photo = CollectionPhoto.find(params[:id])
    
end

# 'POST ''admin/collection_photos'
def create
    
  @photo = CollectionPhoto.new(photo_params)
  
  @photo.save
  
  redirect_to admin_collection_photo(@photo)
  
end

# GET 'admin/collection_photos/:id/edit'
def edit
  
  @photo = CollectionPhoto.find(params[:id])
  @available_tags = CollectionTag.all

end

# PATCH/PUT 'admin/collection_photos/:id'
#
# tag (and/or delete) params[:id] with collection_tags 
# whose ids are given in params[:tag_with_ids] ( or in params[:delete_tag_ids])
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
  redirect_to edit_admin_collection_photo_path(photo)

end


# DELETE 'admin/collection_photos/:id'
def destroy
  
  #@photo=CollectionPhoto.find(params[:id])
  #@photo.destroy
  #redirect_to collection_photos_path
  render plain: "action to be implemented"
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
