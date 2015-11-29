class Admin::CollectionViewsController < ApplicationController

# Each view shows photos tagged under associated tags

# GET 'admin/collection_views'
def index
  @views = CollectionView.all
end

#GET '/admin/collection_views/new'
def new

#collapse to index
#redirect_to collection_views_path

end

# POST '/admin/collection_views'
def create

  view = CollectionView.new(view_params)
  view.save
  redirect_to admin_collection_views_path 

end
 

# GET admin/collection_views/:id/edit 
def edit

  @TYPES = CollectionView.view_types
  @view = set_view
  @tags = @view.collection_tags
  @available_tags = CollectionTag.all
  
end

# PATCH/PUT 'admin/collection_views/:id/edit'
def update

this_view = set_view

# three separate actions:
  
  if params[:add_tags_ids]   
    
    tags_to_append = CollectionTag.find(params[:add_tags_ids]) 
    
    tags_to_append.each do |tag|  
      if !this_view.collection_tags.exists?(tag.id)
      this_view.collection_tags<< tag
      end 
    end
    
  end
  
  if params[:delete_tags_ids] 
    
    tags_to_delete = this_view.collection_tags.find(params[:delete_tags_ids])
    
    tags_to_delete.each { |tag| this_view.collection_tags.destroy(tag) }
    
  end

  if params[:collection_view] # else sets the type of the view
    
      
    this_view.name = params[:collection_view][:name]  
   
    if params[:view_type] 

      this_view.view_type = params[:view_type] 
    end  

    this_view.save!
    
  end
  
  redirect_to edit_admin_collection_view_path(this_view)
 
#render plain: params.inspect
end

# GET 'admin/collection_views/:id'
def show
 
 @this_view = set_view
 
 keywords = []
 @this_view.collection_tags.each {  |tag| keywords<< tag.keyword }
 
 @photos = CollectionPhoto.tagged_with(keywords, :on => :keywords, :any => true)
  
  #render plain: @photos.each {|photo| puts photo.name}
  #render plain: keywords.inspect
end


def destroy
render plain: "action to be implemented"
end

private

# whitelists attributes
def view_params 
  
  params.require(:collection_view).permit(:name,:type_view)
  
end

# callbacks for shared resources across actions
def set_view
  CollectionView.find(params[:id])
end

end
