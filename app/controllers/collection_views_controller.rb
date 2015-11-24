class CollectionViewsController < ApplicationController

# Each collection_view shows collection_photos tagged under associated collection_tags

def index

  @views = CollectionView.all
end

def new

end

# GET /collection_views/:id
def show
  
end

# POST /collection_views
def create

  view = CollectionView.new(view_params)
  view.save
  redirect_to collection_views_path 
end
 

# GET collection_views/:id/edit 
def edit

  @view = this_view
  @tags = @view.collection_tags
  @available_tags = CollectionTag.all
  
end

# PATCH/PUT collection_views/:id/edit
def update

# three separate actions:
  
  if params[:add_tags_ids] 
    
    tags_to_append = CollectionTag.find(params[:add_tags_ids]) 
    tags_to_append.each { |tag| this_view.collection_tags<< tag}
    
  end
  
  if params[:delete_tags_ids] 
    
    tags_to_delete = this_view.collection_tags.find(params[:delete_tags_ids])
    
    tags_to_delete.each { |tag| this_view.collection_tags.destroy(tag) }

  else
    
  
  end
  
  redirect_to edit_collection_view_path(this_view)
  
end

# GET collection_views/:id
def show
 # TODO: let @view given by id in params, 
 # then generate array @photos based on the 
 # owned taggings of @view.
 # Use view of current collection_photos#slideshow. 
 @view = CollectionPhoto.all
end

private

def view_params 
# whitelists attributes
# 'name' CollectionView model
  
  params.require(:collection_view).permit(:name)
  
end

# callback to all actions in the controller
def this_view
  CollectionView.find(params[:id])
end

end
