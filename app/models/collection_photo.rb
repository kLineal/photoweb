class CollectionPhoto < ActiveRecord::Base

### TAGGINGS

# context maps to attribute 'keyword' of collection_tag table 
acts_as_taggable_on :keywords


### CLASS METHODS

# returns an array of common keywords
def CollectionPhoto.find_join_keywords_of photo_batch 

  join_keywords= photo_batch.first.keyword_list
  photo_batch.each {|photo| join_keywords = join_keywords & photo.keyword_list }
  
  join_keywords
end


### INSTANCE MEHTODS

def path_to_image

  # constant defined in config/initializers/constants.rb
  path_to_image = "#{COLLECTION_FOLDER_PATH}/" << self.name  

end

end
