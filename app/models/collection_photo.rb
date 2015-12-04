class CollectionPhoto < ActiveRecord::Base

# context maps to attribute 'keyword' of collection_tag table 
acts_as_taggable_on :keywords

end
