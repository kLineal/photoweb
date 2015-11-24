class CollectionView < ActiveRecord::Base

has_and_belongs_to_many :collection_tags, join_table: "collection_tags_views"

def self.view_types

  ['cover', 'partial']

end

end
