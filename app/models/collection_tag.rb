class CollectionTag < ActiveRecord::Base

has_and_belongs_to_many :collection_views, join_table: "collection_tags_views" 
end
