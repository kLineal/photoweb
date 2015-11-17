class CollectionView < ActiveRecord::Base

# views can tag collection_photo objects
acts_as_tagger
end
