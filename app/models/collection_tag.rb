class CollectionTag < ActiveRecord::Base


### ASSOCIATIONS
has_and_belongs_to_many :collection_views, 
                        join_table: "collection_tags_views" 


#### CALLBACKS
before_destroy :remove_from_views
before_destroy :untag_photos



### INSTANCE METHODS
def remove_from_views
  
  self.collection_views.clear

end

# return any collection_photo record tagged with tag keyword
def tagged_photos

 CollectionPhoto.tagged_with(self.keyword, :on => :keywords, :any => true)

end

def untag_photos
  
  
  if self.tagged_photos.any? 
    
    self.tagged_photos.each do |photo| 
      
      photo.keyword_list.remove(self.keyword) 
      photo.save!
      photo.reload   
      
    end
  end
  
  self
end
  
end
