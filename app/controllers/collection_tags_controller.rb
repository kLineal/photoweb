class CollectionTagsController < ApplicationController

def index 
@current_keywords = CollectionTag.all
end

def create

  @tag = CollectionTag.new(tag_params)
  
  @tag.save
  
  # render index of tags
  @current_keywords = CollectionTag.all
  redirect_to collection_tags_path

end

private

def tag_params #whitelists attribute 'keyword' of CollectionTag model
  
  params.require(:collection_tag).permit(:keyword)
  
end
end
