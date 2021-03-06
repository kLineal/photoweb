class CollectionView < ActiveRecord::Base

### ASSOCIATIONS

has_and_belongs_to_many :collection_tags, 
                        join_table: "collection_tags_views"


### CALLBACKS

before_destroy :clear_associated_tags

### CLASS METHODS

# two types of views:
#                    - exclusive (all views of this type are pairwise disjoint and cover the entire collection)
#                    - non-exclusive (views are partial, so a photo can be included in two distinct partial views)
def CollectionView.types

  ['cover', 'partial']

end



#### INSTANCE METHODS


# get keyword attribute of associated collection_tag records
def keywords
  keywords = []
  self.collection_tags.each {  |tag| keywords<< tag.keyword }
  keywords
end

# photos of a view are those tagged  with associated 'keywords' 
# as a _subset_ of their tags: match_any
def photos

  keywords = self.keywords
  CollectionPhoto.tagged_with(keywords, :on => :keywords, :match_any => true)

end

#number of photos
def number_of_photos
 
 self.photos.size

end

def clear_associated_tags
  
  self.collection_tags.clear
  
end

end
