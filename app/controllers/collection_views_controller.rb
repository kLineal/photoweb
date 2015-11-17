class CollectionViewsController < ApplicationController

# Handles taggable CollectionPhoto acting as tagger.
# Each collection_view shows collection_photos tagged under its own tags (keywords taken from universe collection_tag)

def show
 # TODO: let @view given by id in params, 
 # then generate array @photos based on the 
 # owned taggings of @view.
 # Use view of current collection_photos#slideshow. 
 @view = CollectionPhoto.all
end

end
