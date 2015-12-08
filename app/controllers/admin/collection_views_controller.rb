class Admin::CollectionViewsController < ApplicationController

# Each collection_view shows collection_photos 
# that are tagged with associated collection_tag records

# GET 'admin/collection_views'
def index
  @views = CollectionView.all
end

#GET '/admin/collection_views/new'
def new

@TYPES = CollectionView.view_types

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
 
end

# GET 'admin/collection_views/:id'
def show
 
 @this_view = set_view
 @photos = @this_view.photos
  
end

# DELETE /admin/collection_views/:id
def destroy

this_view = set_view

# callback to clear associated collection_tags
#             from the join table
this_view.destroy

redirect_to admin_collection_views_path
#render plain: "action to be implemented"
end

private

# whitelists attributes
def view_params 
  
  params.require(:collection_view).permit(:name,:view_type)
  
end

# callbacks for shared resources across actions
def set_view
  CollectionView.find(params[:id])
end

end
