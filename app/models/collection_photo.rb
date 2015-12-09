class CollectionPhoto < ActiveRecord::Base

# context maps to attribute 'keyword' of collection_tag table 
acts_as_taggable_on :keywords

def path_to_image
  # constant defined in config/initializers/constants.rb
  path_to_image = "#{COLLECTION_FOLDER_PATH}/" << self.name  
end

end
