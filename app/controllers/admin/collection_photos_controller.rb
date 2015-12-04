class Admin::CollectionPhotosController < ApplicationController

# Photos are tagged with keywords (from collection_tags table) 
# This allows to render partial and disjoint (covers) views of 
# the collection.

def new 

end

# GET 'admin/collection_photos'
#
# index with filter capabilities
def index
  
  @all_collection_tags = CollectionTag.all
  
  # show either photos filtered by @filter or all
  @filter = []
  if params[:filter_by_keywords]
    
    @filter = params[:filter_by_keywords]
    @photos = CollectionPhoto.tagged_with(@filter, :on => :keywords, :any => true)
    
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
  
  @photo.save!
  
  redirect_to admin_collection_photo(@photo)
  
end

# GET 'admin/collection_photos/:id/edit'
def edit
  
  @photo = CollectionPhoto.find(params[:id])
  @available_tags = CollectionTag.all
  
end

# PATCH/PUT 'admin/collection_photos/:id'
#
# adds and/or remove keywords to collection_photo in params[:id]
# first remove then add (removing and adding a keywords untouches it)
def update

  photo = CollectionPhoto.find(params[:id])
  
  
  photo.keyword_list.remove(params[:keywords_to_delete]) if params[:keywords_to_delete]

  photo.keyword_list.add(params[:keywords_to_append])    if params[:keywords_to_append]
  
  photo.save!
  photo.reload
  redirect_to edit_admin_collection_photo_path(photo)
  #render plain: params[:keywords_to_append].inspect
end

# "GET 'admin/collection_photos/edit_batch'
def edit_batch

if params[:photos_to_tag_ids]
    @batch = CollectionPhoto.find(params[:photos_to_tag_ids])
else
  @batch = CollectionPhoto.find(params[:filtered_index_ids])
end

@collection_tags = CollectionTag.all

# find join tags (so we can batch-delete them if wanted to)
@join_keywords= @batch.first.keyword_list
@batch.each {|photo| @join_keywords = @join_keywords & photo.keyword_list }

end

# PUT 'admin/collection_photos/'
def update_batch
  
  if params[:photo_batch_ids]
  
    photos = CollectionPhoto.find(params[:photo_batch_ids])
    
    photos.each do |photo|
      
      photo.keyword_list.remove(params[:keywords_to_delete]) if  params[:keywords_to_delete]
      photo.keyword_list.add(params[:keywords_to_append])    if  params[:keywords_to_append]
      
      photo.save!
      photo.reload

    end
    
  end


#    
    
#    photos = CollectionPhoto.find(params[:photos_to_tag_ids])
#    keywords = get_keywords(params[:tag_with_ids])
   
#    photos.each do |photo| 
      
      #photo.keyword_list.add(keywords)
      #photo.save 
      #photo.reload
    
#    end
  
redirect_to admin_collection_photos_path
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


end
