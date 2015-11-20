class CollectionPhoto < ActiveRecord::Base

# For clarity: the context maps to column 'keyword' 
# of CollectionTag model 
acts_as_taggable_on :keywords
end
